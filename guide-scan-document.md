# Document Scanner Integration Guide

In this guide, we will explore the Document Scanner features of the [Dynamsoft Capture Vision](https://pub.dev/documentation/dynamsoft_capture_vision_flutter/latest/) SDK.

## Requirements

### Dev tools

* Latest [Flutter SDK](https://flutter.dev/)
* For Android apps: Android SDK (API Level 21+), platforms and developer tools
* For iOS apps: iOS 13+, macOS with latest Xcode and command line tools

### Mobile platforms

* Android 5.0 (API Level 21) and higher
* iOS 13 and higher

## Installation

Run the following commands in the root directory of your flutter project to add `dynamsoft_capture_vision_flutter` into dependencies

```bash
flutter pub add dynamsoft_capture_vision_flutter
```

then run the command to install all dependencies:
```bash
flutter pub get
```

## Camera permissions

The Dynamsoft Capture Vision SDK needs the camera permission to use the camera device, so it can capture from video stream.

### Android

Before opening camera to start capturing, you need to request camera permission from system.

```dart
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';

PermissionUtil.requestCameraPermission();
```

### iOS

Add this camera permission description to **ios/{projectName}/Info.plist** inside the <dict> element:

```xml
<key>NSCameraUsageDescription</key>
    <string></string>
```

## Build the Document Scanner Widget

Now that the package is added, it's time to start building the document scanner Widget using the SDK.

### Initialize License

The first step in code configuration is to initialize a valid license via `LicenseManager.initLicense`.

```dart
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';

LicenseManager.initLicense('DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9').then((data) {
      final (isSuccess, message) = data;
      if (!isSuccess) {
        print("license error: $message");
      }
    });
```

> [!NOTE]
>
>- The license string here grants a time-limited free trial which requires network connection to work.
>- You can request a 30-day trial license via the [Request a Trial License](https://www.dynamsoft.com/customer/license/trialLicense?product=dcv&utm_source=guide&package=mobile) link.

## Implement Document Scanning from Video Stream

The basic workflow of scanning a document from video stream is as follows:

- Initialize the `CameraEnhancer` object
- Initialize the `CaptureVisionRouter` object
- Bind the `CameraEnhancer` object to the `CaptureVisionRouter` object
- Add a 'MultiFrameResultCrossFilter' object to enable the verification for document detection
- Register a `CapturedResultReceiver` object to listen for scanned document via the callback function `onProcessedDocumentResultReceived`
- Open the camera
- Start document scanning via `startCapturing`

```dart
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final String _templateName = EnumPresetTemplate.detectAndNormalizeDocument;
  final CaptureVisionRouter _cvr = CaptureVisionRouter.instance
    ..addResultFilter(
      MultiFrameResultCrossFilter()
        ..enableResultCrossVerification(EnumCapturedResultItemType.detectedQuad.value, true),
    );
  final CameraEnhancer _camera = CameraEnhancer.instance;
  late final CapturedResultReceiver _receiver = CapturedResultReceiver()
    ..onProcessedDocumentResultReceived = (ProcessedDocumentResult result) async {
      if (result.deskewedImageResultItems?.isNotEmpty ?? false) {
        var item = result.deskewedImageResultItems![0];
        if (item.crossVerificationStatus == EnumCrossVerificationStatus.passed || _isBtnClicked) {
          final originalImage = await CaptureVisionRouter.getOriginalImage(result.originalImageHashId)!; //Please call getOriginalImage before _cvr.stopCapturing()
          final deskewedImage = item.imageData!;
          final sourceDeskewQuad = item.sourceDeskewQuad;
          //Do something with the item and the original image
        }
      }
    };

  @override
  void initState() {
    super.initState();
    PermissionUtil.requestCameraPermission();
    LicenseManager.initLicense('DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9').then((data) {
      final (isSuccess, message) = data;
      if (!isSuccess) {
        print("license error: $message");
      }
    });
    initSdk();
  }

  void initSdk() async {
    await _cvr.setInput(_camera); //bind CameraEnhancer and CaptureVisonRouter
    _cvr.addResultReceiver(_receiver); //Register `CapturedResultReceiver` object to listen for parsed VIN code
    _camera.open();
    try {
      await _cvr.startCapturing(_templateName); //Start capturing
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cvr.stopCapturing();
    _camera.close();
    _cvr.removeResultReceiver(_receiver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(child: CameraView(cameraEnhancer: _camera)), // Bind CameraView and CameraEnhancer
    );
  }
}
```

## Customize the Document Scanner

If you want to detect document boundary and adjust the boundary manually, you can `startCapturing` with `EnumPresetTemplate.detectDocumentBoundaries` template. 
The `ProcessedDocumentResult` will then be received through the `onProcessedDocumentResultReceived` callback. 
You can use the [Editor component](./ScanDocument/lib/edit_page.dart) to learn how to draw `ProcessedDocumentResult.detectedQuadResultItems` on the original image and interactively edit the quads.

## Run the project

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

If everything is set up _correctly_, you should see your new app running on your device.

## Full Sample Code
The full sample code is available [here](./ScanDocument).

## License

- You can request a 30-day trial license via the [Request a Trial License](https://www.dynamsoft.com/customer/license/trialLicense?product=dcv&utm_source=github&package=mobile) link.

## Contact

https://www.dynamsoft.com/company/contact/
