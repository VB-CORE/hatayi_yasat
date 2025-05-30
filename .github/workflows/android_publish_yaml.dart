name: Android UI Tests To FirebaseTestLab

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  android_test:
    runs-on: ubuntu-latest

    steps:
      - name: ⬇️ Checkout code
        uses: actions/checkout@v3

      - name: 🔧 Set up Java 17
        uses: actions/setup-java@v3
        with:
          distribution: "temurin"
          java-version: "17"

      - name: 🔁 Cache Flutter SDK
        uses: actions/cache@v3
        id: flutter-cache
        with:
          path: ~/flutter
          key: ${{ runner.os }}-flutter-stable-v1

      - name: 🔽 Install Flutter SDK
        if: steps.flutter-cache.outputs.cache-hit != 'true'
        run: |
          git clone https://github.com/flutter/flutter.git --branch stable --depth 1 ~/flutter

      - name: 🛠️ Add Flutter to PATH
        run: echo "$HOME/flutter/bin" >> $GITHUB_PATH

      - name: 📦 Cache Flutter dependencies
        uses: actions/cache@v3
        with:
          path: |
            ${{ github.workspace }}/.pub-cache
            ${{ github.workspace }}/build
          key: ${{ runner.os }}-flutter-${{ hashFiles('**/pubspec.lock') }}
          restore-keys: |
            ${{ runner.os }}-flutter-

      - name: 🔐 Decrypt Android keys
        run: sh ./.github/scripts/decrypt_android_keys.sh

      - name: 📦 flutter pub get
        run: flutter pub get

      - name: 🚀 Install FlutterFire CLI
        run: dart pub global activate flutterfire_cli

      - name: 💎 Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: "3.0"
          bundler-cache: true

      - name: 📦 bundle install
        run: bundle install
        working-directory: android

      - name: 🔤 Run Android scripts
        run: ./scripts/build.sh force && ./scripts/lang.sh

      - name: 🚀 Activate Patrol CLI
        run: dart pub global activate patrol_cli

      - name: 🏗️ Build APKs
        run: patrol build android --target integration_test/start_test.dart --flavor development

      - id: auth
        name: 🔐 Authenticate to Google Cloud
        uses: google-github-actions/auth@v2
        with:
          credentials_json: '${{ secrets.GCP_CREDENTIALS_DEV }}'

      - name: ☁️ Set up gcloud SDK
        uses: google-github-actions/setup-gcloud@v2

      - name: 🧪 Run Firebase Test Lab
        run: |
          gcloud firebase test android run \
          --type instrumentation \
          --use-orchestrator \
          --app build/app/outputs/apk/development/debug/app-development-debug.apk \
          --test build/app/outputs/apk/androidTest/development/debug/app-development-debug-androidTest.apk \
          --timeout 1m \
          --device model=MediumPhone.arm,version=34,locale=en,orientation=portrait \
          --record-video \
          --environment-variables=clearPackageData=true,IS_TEST_LAB=true \
          --project hatayiyasat\
          --results-dir=test_results \
          --results-history-name=instrumentation_tests