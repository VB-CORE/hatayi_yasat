#!/bin/bash

# patrol devices çıktısından iPhone içeren satırdan cihaz ID'sini al
booted_device_id=$(patrol devices | grep -i 'iPhone' | grep -oE '[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}')

# Eğer ID bulunamazsa hata ver
if [ -z "$booted_device_id" ]; then
  echo "iPhone emulator not found. Please start an iOS emulator."
  exit 1
fi

echo "iPhone emulator found: $booted_device_id"

# # Patrol komutunu çalıştır
patrol develop --target integration_test/start_test.dart --device "$booted_device_id"
