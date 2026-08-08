# Upgrade Notes

Findings from the Flutter 3.44.9 dependency upgrade. Everything here is a
constraint imposed by someone else's package, not by this repo. Each entry
says what would have to change upstream before we can move.

## Packages held below latest

| Package | We use | Latest | Held by |
| --- | --- | --- | --- |
| `share_plus` | 12.0.2 | 13.3.0 | `file_picker` needs win32 ^5; share_plus >=13 needs win32 ^6 |
| `device_info_plus` | 12.4.0 | 13.2.0 | same win32 split |
| `syncfusion_flutter_pdfviewer` | 33.2.15 | 34.2.2 | 34 declares `device_info_plus ^13.1.0`, unreachable behind win32 ^5 |
| `image_cropper` | 11.0.0 | 12.2.1 | `file_picker` → DKImagePickerController → TOCropViewController 2.6–3.0 |
| `build_runner` | 2.15.1 | 2.16.0 | 2.16 needs analyzer >=13.3 → meta ^1.18.3; Flutter 3.44.9 pins meta 1.18.0 |
| `mockito` (life_shared) | 5.7.x | 5.8.1 | same meta 1.18.0 ceiling |

The win32 ^5 vs ^6 split is the single biggest blocker: it holds back three
packages at once. `file_picker` is the only thing keeping us on win32 ^5, and
this app does not ship a Windows target at all.

## Upstream items

### kartal — two overrides exist only because of it

`kartal` 4.2.0 declares:

- `share_plus: ^11.0.0` — but it only calls the deprecated `Share.share()`,
  which still exists in 12.x and 13.x. The constraint is stricter than the
  code needs.
- `device_info_plus: ^11.3.1` — conflicts with syncfusion's `^12.1.0`.

Both are worked around with `dependency_overrides`. Fixing either upstream
removes an override here. The share_plus one would be cleanest as a migration
to `SharePlus.instance.share(ShareParams(...))`, which this app already uses
directly.

Call site: `kartal-4.2.0/lib/src/private/platform/app_platform.dart:69,76`.

### file_picker — win32 and DKImagePickerController

Two separate problems in one package:

1. Every stable release requires `win32: ^5.9.0`, which caps share_plus and
   device_info_plus for the whole app. `file_picker 12.0.0-beta.1` appears to
   move to win32 ^6 but is not released.
2. Its SPM manifest pins `DKImagePickerController` to `branch: "4.3.9"`,
   which requires `TOCropViewController` 2.6.0–3.0.0. That is what caps
   `image_cropper` at 11.

Replacing file_picker would unblock four packages at once — worth evaluating
separately from this upgrade.

### image_cropper 12.0.0 — broken SPM manifest

`ios/image_cropper/Package.swift` declares
`TOCropViewController from: "2.8.0"` (i.e. 2.8.0..<3.0.0), but
`FLTImageCropperPlugin.m` includes `TOCropViewController/TOCropViewConstants.h`,
a 3.x header layout. Building with SPM fails:

```
Lexical or Preprocessor Issue (Xcode): 'TOCropViewController/TOCropViewConstants.h' file not found
image_cropper-12.0.0/ios/image_cropper/Sources/image_cropper/FLTImageCropperPlugin.m:2:8
```

12.1.0+ fixed the manifest (`from: "3.1.1"`), so 12.0.0 is the only broken
version — but it is also the only 12.x that could have satisfied
DKImagePickerController's 2.x range. Worth reporting so nobody else loses time
on it.

### google_maps_flutter_ios — no Swift Package Manager support

2.18.4 ships only `ios/google_maps_flutter_ios.podspec`, no `Package.swift`.
It is the last plugin in this app without SPM support, so `pod install` still
runs for it. Harmless today (it produces no duplicate symbols), but Flutter
has said the fallback will eventually become an error.

### cloud_firestore 6 — `Type` leaks from the public barrel

`package:cloud_firestore/cloud_firestore.dart` exports a pipeline-expression
class named `Type`, which shadows `dart:core`'s `Type` in every file importing
the barrel. In life_shared this broke a `Map<Type, Function>` converter cache
and required `import ... hide Type`. Any consumer using `Type` in a
Firestore-importing file hits this.

## Local decisions worth remembering

- `google_fonts` was removed rather than upgraded: zero references in `lib/`
  or `test/`. Typography is the bundled PlusJakartaSans / DMSerifDisplay pair.
- iOS deployment target moved 13.0 → 15.0. Not a support drop: `ios/Podfile`
  already declared `platform :ios, "15.0"` and CocoaPods was overriding the
  Xcode project setting. SPM does not override it, so the mismatch surfaced.
- `sqflite_android`'s override was removed; it resolves on its own now.
