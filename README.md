# henry_capture_vision_flutter

A lightweight Flutter barcode scanner plugin implemented with [Dynamsoft Camera Enhancer](https://www.dynamsoft.com/camera-enhancer/docs/introduction/) and [Dynamsoft Barcode Reader](https://www.dynamsoft.com/barcode-reader/overview/).

## Supported Platforms
- **Android**
- **iOS**

## Mobile Camera and Barcode SDK Version
- Dynamsoft Camera Enhancer 2.1.4
- Dynamsoft Barcode Reader 9.0.2

## Build Configuration

### Android
Change the minimum Android sdk version to 21 (or higher) and change the compile sdk version to 31 (or higher) in your `android/app/build.gradle` file.

```gradle
minSdkVersion 21
compileSdkVersion 31
```

### iOS

Add camera access permission to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
```
