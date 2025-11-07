# Dynamsoft Capture Vision Flutter Samples

This repository contains multiple samples that show you how use the Dynamsoft Capture Vision Flutter SDK.

## Requirements

### Dev tools

* Latest [Flutter SDK](https://flutter.dev/)
* For Android apps: Android SDK (API Level 21+), platforms and developer tools
* For iOS apps: iOS 13+, macOS with latest Xcode and command line tools

### Mobile platforms

* Android 5.0 (API Level 21) and higher
* iOS 13 and higher

## Integration Guide For Your Project

- [MRZ Scanner Integration Guide](./guide-scan-mrz.md)
- [Document Scanner Integration Guide](./guide-scan-document.md)
- [VIN Scanner Integration Guide](./guide-scan-vin.md)

## API Reference

- [MRZ Scanner API Reference](https://pub.dev/documentation/dynamsoft_mrz_scanner_bundle_flutter/latest/)
- [Capture Vision API Reference](https://pub.dev/documentation/dynamsoft_capture_vision_flutter/latest/)

## Samples

| Sample Name                  | Description                                                                                                                              |
|------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| [ScanMRZ](ScanMRZ)           | This sample illustrates how to scan passport and ID cards from video streaming.                                                          |
| [ScanDocument](ScanDocument) | This sample illustrates how to detect and deskew document pages from the video stream.                                                   |
| [ScanVIN](ScanVIN)           | This sample illustrates how to Scan the VIN code from a barcode or a text line and extract the vehicle information from video streaming. |

## How to build and run a sample

### Step 1: Enter a sample folder that you want to try

```bash
cd ScanMRZ
```
or
```bash
cd ScanDocument
```
or
```bash
cd ScanVIN
```

### Step 2: Fetch and install the dependencies of this example project via Flutter CLI:

```
flutter pub get
```

Connect a mobile device via USB and run the app.

### Step 3: Start your application

**Android:**

```
flutter run -d <DEVICE_ID>
```

You can get the IDs of all connected devices with `flutter devices`.

**iOS:**

Install Pods dependencies:

```
cd ios/
pod install --repo-update
```

Open the **workspace**(!) `ios/Runner.xcworkspace` in Xcode and adjust the *Signing / Developer Account* settings. Then, build and run the app in Xcode.

> [!NOTE]
>- The license string here grants a time-limited free trial which requires network connection to work.
>- You can request a 30-day trial license via the [Request a Trial License](https://www.dynamsoft.com/customer/license/trialLicense?product=dcv&utm_source=guide&package=mobile) link.

## Support

https://www.dynamsoft.com/company/contact/
