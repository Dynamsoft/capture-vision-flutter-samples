# Dynamsoft Capture Vision Flutter Edition

<a href="https://www.dynamsoft.com/capture-vision/docs/introduction/">Dynamsoft Capture Vision (DCV) </a> is an aggregating SDK of a series of specific functional products including:

- Dynamsoft Camera Enhancer (DCE) which provides camera enhancements and UI configuration APIs.
- Dynamsoft Barcode Reader (DBR) which provides barcode decoding algorithm and APIs.
- Dynamsoft Label Recognizer (DLR) which provides label content recognizing algorithm and APIs.
- Dynamsoft Document Normalizer (DDN) which provides document scanning algorithms and APIs.

>Note: DCV Flutter edition currently only includes DCE and DBR modules. DLR and DDN modules are still under development and will be included in the future.

<span style="font-size:20px">Table of Contents</span>

- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Build Your Barcode Scanner App](#build-your-barcode-scanner-app)
  - [Set up Development Environment](#set-up-development-environment)
  - [Initialize the Project](#initialize-the-project)
  - [Include the Library](#include-the-library)
  - [License Activation](#license-activation)
  - [Configure the Barcode Reader](#configure-the-barcode-reader)
  - [Build the Widget](#build-the-widget)
  - [Configure Camera Permissions](#configure-camera-permissions)
  - [Run the Project](#run-the-project)
- [Samples](#samples)
- [API References](#api-references)
- [License](#license)
- [Contact](#contact)

## System Requirements

### Flutter & Dart

- Flutter version: >=2.0.0
- Dart version: >=2.12.0 <3.0.0

### Android

- Supported OS: Android 5.0 (API Level 21) or higher.
- Supported ABI: **armeabi-v7a**, **arm64-v8a**, **x86** and **x86_64**.
- Development Environment: Android Studio 3.4+ (Android Studio 4.2+ recommended).
- JDK: 1.8+

### iOS

- Supported OS: **iOS 10.0** or higher.
- Supported ABI: **arm64** and **x86_64**.
- Development Environment: Xcode 7.1 and above (Xcode 13.0+ recommended), CocoaPods 1.11.0+.

## Installation

Run the following command:

```bash
flutter pub add dynamsoft_capture_vision_flutter
```

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```dart
dependencies:
   dynamsoft_capture_vision_flutter: ^1.0.0
```

## Build Your Barcode Scanner App

Now you will learn how to create a simple barcode scanner using Dynamsoft Capture Vision Flutter SDK.

### Set up Development Environment

If you are a beginner with Flutter, please follow the guide on the <a href="https://docs.flutter.dev/get-started/install" target="_blank">Flutter official website</a> to set up the development environment.

### Initialize the Project

Create a new Flutter project

```bash
flutter create simple_barcode_scanner
```

### Include the Library

View the [installation section](#installation) for how to add the library. In **main.dart** of your project, import the library.

```dart
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
```

### License Activation

The barcode reading module of Dynamsoft Capture Vision needs a valid license to work. In the **main()** function, add the following code to activate the license.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Put your Dynamsoft Barcode Reader license here.
  const String licenseKey = '';
  // Initialize the license so that you can use full feature of the Barcode Reader module.
  try {
    await DynamsoftBarcodeReader.initLicense(license: licenseKey);
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}
```

### Configure the Barcode Reader

In this section, we are going to work on the **_MyHomePageState** class in the newly created project to add the barcode decoding feature.

Add the following instance variables:

```dart
class _MyHomePageState extends State<MyHomePage> {
  late final DynamsoftBarcodeReader _barcodeReader;
  final DynamsoftCameraView _cameraView = DynamsoftCameraView();
  List<BarcodeResult> decodeResults = [];
}
```

- `barcodeReader`: The object that implements barcode decoding feature. Users can configure barcode decoding settings via this object.
- `cameraView`: The camera view that displays the video streaming.
- `decodeResults`: An object that will be used to receive and stores barcode decoding result.

Add **_configDBR** method to initialize the barcode reader:

```dart
class _MyHomePageState extends State<MyHomePage> {
  ...
  @override
  void initState() {
    super.initState();
    _configDBR();
  }

  _configDBR() async {
    /// Create an instance of barcode reader.
    _barcodeReader = await DynamsoftBarcodeReader.createInstance();

    /// Receive the barcode decoding results and store the result in object decodeResults
    _barcodeReader.receiveResultStream().listen((List<BarcodeResult> res) {
      if (mounted) {
        setState(() {
          decodeResults = res;
        });
      }
    });

    /// Start barcode decoding when the widget is created.
    _barcodeReader.startScanning();

    /// When overlayVisible is set to true, the decoded barcodes will be highlighted with overlays.
    _cameraView.overlayVisible = true;
  }
}
```

Add configurations to parse and display the barcode decoding results:

```dart
class _MyHomePageState extends State<MyHomePage> {
  ...
  /// Get listItem
  Widget listItem(BuildContext context, int index) {
    BarcodeResult res = decodeResults[index];

    return ListTileTheme(
        textColor: Colors.white,
        // tileColor: Colors.green,
        child: ListTile(
          title: Text(res.barcodeFormatString),
          subtitle: Text(res.barcodeText),
        ));
  }
}
```

### Build the Widget

Modify the **build** method to display the decode barcode results on the widget.

```dart
class _MyHomePageState extends State<MyHomePage> {
  ...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HelloWorld'),
      ),
      body: Stack(
        children: [
          Container(
            child: _cameraView,
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemBuilder: listItem,
              itemCount: decodeResults.length,
            ),
          ),
        ],
      ));
  }
}
```

### Configure Camera Permissions

Before you run the project on iOS devices, you have to add the camera permission first.

In the project folder, go to file **ios/Runner/info.plist**, add the following code for requesting camera permission.

```xml
<plist version="1.0">
<dict>
  ...
  <key>NSCameraUsageDescription</key>
  <string>Request your authorization.</string>
  ...
</dict>
```

### Run the Project

#### Run Android on Windows

Go to the file **build.gradle(app)**, update the `minSdkVersion` to 21.

```gradle 
android {
   defaultConfig {
      ...
      minSdkVersion 21
      ...
   }
}
```

In the root of your project run the following command to build and install the app:

```bash
flutter run
```

#### Run iOS on macOS

Go to the **podfile** in **ios** folder and add the following code at the top of the file:

```objc
platform:ios, '10.0'
```

In the root of your project run the following command to build and install the app:

```bash
flutter run
```

## Samples

You can view all the DCV Flutter samples via the following links:

- <a href = "https://github.com/Dynamsoft/capture-vision-flutter-samples/tree/main/BarcodeReaderSimpleSample" target = "_blank" >Barcode reader simple sample</a>

## API References

View the API reference of DCV Flutter Edition to explore the full feature of DCV:

- <a href = "https://www.dynamsoft.com/capture-vision/docs/programming/flutter/api-reference/?ver=latest" target = "_blank" >DCV API Reference - Flutter Edition</a>
  - <a href = "https://www.dynamsoft.com/capture-vision/docs/programming/flutter/api-reference/barcode-reader.html?ver=latest" target = "_blank" >DynamsoftBarcodeReader Class</a>
  - <a href = "https://www.dynamsoft.com/capture-vision/docs/programming/flutter/api-reference/camera-view.html?ver=latest" target = "_blank" >DynamsoftCameraEnhancer Class</a>

## License

- You can also request an extension for your trial license in the [customer portal](https://www.dynamsoft.com/customer/license/trialLicense?product=dbr&utm_source=github)

## Contact

https://www.dynamsoft.com/company/contact/
