import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibration/vibration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Put your Dynamsoft Barcode Reader license here.
  const String licenseKey =
      'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTEwMTIwMDkzNiIsIm9yZ2FuaXphdGlvbklEIjoiMjAwMDAxIn0=';

  // Initialize the license so that you can use full feature of the Barcode Reader module.
  try {
    await DCVBarcodeReader.initLicense(licenseKey);
  } catch (e) {
    print(e);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Reader Simple Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? path;

  void _startScanning() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BarcodeScanner()));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: _startScanning,
            child: Text('Start Scanning'),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class BarcodeScanner extends StatefulWidget {
  BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with WidgetsBindingObserver {
  late final DCVBarcodeReader _barcodeReader;
  late final DCVCameraEnhancer _cameraEnhancer;
  late final ImagePicker _picker;

  final DCVCameraView _cameraView = DCVCameraView();

  List<BarcodeResult> decodeRes = [];
  String? resultText;
  String? base64ResultText;
  bool faceLens = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _picker = ImagePicker();
    _sdkInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _cameraEnhancer.close();
    _barcodeReader.stopScanning();
    super.dispose();
  }

  void _sdkInit() async {
    // Create a barcode reader instance.
    _barcodeReader = await DCVBarcodeReader.createInstance();
    _cameraEnhancer = await DCVCameraEnhancer.createInstance();

    // Get the current runtime settings of the barcode reader.
    DBRRuntimeSettings currentSettings =
        await _barcodeReader.getRuntimeSettings();
    // Set the barcode format to read.
    currentSettings.barcodeFormatIds = EnumBarcodeFormat.BF_ONED |
        EnumBarcodeFormat.BF_QR_CODE |
        EnumBarcodeFormat.BF_PDF417 |
        EnumBarcodeFormat.BF_DATAMATRIX;

    // currentSettings.minResultConfidence = 70;
    // currentSettings.minBarcodeTextLength = 50;

    // Set the expected barcode count to 0 when you are not sure how many barcodes you are scanning.
    // Set the expected barcode count to 1 can maximize the barcode decoding speed.
    currentSettings.expectedBarcodeCount = 0;
    // Apply the new runtime settings to the barcode reader.

    await _barcodeReader.updateRuntimeSettings(currentSettings);

    // Define the scan region.
    _cameraEnhancer.setScanRegion(Region(
        regionTop: 30,
        regionLeft: 15,
        regionBottom: 70,
        regionRight: 85,
        regionMeasuredByPercentage: 1));

    // Enable barcode overlay visiblity.
    _cameraView.overlayVisible = true;

    _cameraView.torchButton = TorchButton(
      visible: true,
    );

    await _barcodeReader.enableResultVerification(true);

    // Stream listener to handle callback when barcode result is returned.
    _barcodeReader.receiveResultStream().listen((List<BarcodeResult>? res) {
      if (mounted) {
        if(res != null && res.length > 0) {
          _vibrateWithBeep();
        }

        setState(() {
          decodeRes = res ?? [];
        });
      }
    });

    await _cameraEnhancer.open();

    // Enable video barcode scanning.
    // If the camera is opened, the barcode reader will start the barcode decoding thread when you triggered the startScanning.
    // The barcode reader will scan the barcodes continuously before you trigger stopScanning.
    _barcodeReader.startScanning();
  }

  /// Get listItem
  Widget listItem(BuildContext context, int index) {
    BarcodeResult res = decodeRes[index];

    return ListTileTheme(
        textColor: Colors.white,
        // tileColor: Colors.green,
        child: ListTile(
          title: Text(res.barcodeFormatString ?? ''),
          subtitle: Text(res.barcodeText),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Barcode Scanner'),
        ),
        body: Stack(
          children: [
            Container(
              child: _cameraView,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                itemBuilder: listItem,
                itemCount: decodeRes.length,
              ),
            ),
            Positioned(
              top: 150,
              left: 25,
              child: GestureDetector(
                onTap: () {
                  faceLens = !faceLens;
                  _cameraEnhancer.selectCamera(faceLens
                      ? EnumCameraPosition.CP_FRONT
                      : EnumCameraPosition.CP_BACK);
                },
                child: Image.asset(
                  'assets/toggle_lens.png',
                  width: 48,
                  height: 48,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 80,
              child: Column(
                children: [
                  Container(
                    width: 160,
                    child: TextButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Text('Select a photo'),
                      style: TextButton.styleFrom(
                          primary: Colors.white, backgroundColor: Colors.blue),
                    ),
                  ),
                  Container(
                    width: 160,
                    child: TextButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      child: Text('Take a photo'),
                      style: TextButton.styleFrom(
                          primary: Colors.white, backgroundColor: Colors.blue),
                    ),
                  ),
                  // Text(
                  //   '${resultText ?? ''}',
                  //   style: TextStyle(color: Colors.black),
                  // ),
                  // Text(
                  //   '${base64ResultText ?? ''}',
                  //   style: TextStyle(color: Colors.black),
                  // ),
                ],
              ),
            )
          ],
        ));
  }

  void _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    final path = image?.path;
    if (path != null) {
      final result = await _barcodeReader.decodeFile(path);

      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate();
      }
      FlutterBeep.beep();

      if (result.isNotEmpty) {
        resultText = result[0].barcodeText;
        final bytes = result[0].barcodeBytes;
        base64ResultText = utf8.decode(bytes);
        decodeRes.addAll(result);
      }
    }
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _barcodeReader.startScanning();
        _cameraEnhancer.open();
        break;
      case AppLifecycleState.inactive:
        _cameraEnhancer.close();
        _barcodeReader.stopScanning();
        break;
      default:
        break;
    }
  }
}
