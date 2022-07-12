import 'package:flutter/material.dart';
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';

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
  void _startScanning() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BarcodeScanner()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TextButton(
          onPressed: _startScanning,
          child: Text('Start Scanning'),
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.blue),
        ),
      ),
    );
  }
}

class BarcodeScanner extends StatefulWidget {
  BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  late final DynamsoftBarcodeReader _barcodeReader;
  final DynamsoftCameraView _cameraView = DynamsoftCameraView();
  List<BarcodeResult> decodeRes = [];

  @override
  void initState() {
    super.initState();
    _sdkInit();
  }

  void _sdkInit() async {
    // Create a barcode reader instance.
    _barcodeReader = await DynamsoftBarcodeReader.createInstance();

    // Get the current runtime settings of the barcode reader.
    DBRRuntimeSettings currentSettings =
        await _barcodeReader.getRuntimeSettings();
    // Set the barcode format to read.
    currentSettings.barcodeFormatIds = EnumBarcodeFormat.BF_ONED |
        EnumBarcodeFormat.BF_QR_CODE |
        EnumBarcodeFormat.BF_PDF417 |
        EnumBarcodeFormat.BF_DATAMATRIX;
    // Set the expected barcode count to 0 when you are not sure how many barcodes you are scanning.
    // Set the expected barcode count to 1 can maximize the barcode decoding speed.
    currentSettings.expectedBarcodeCount = 0;
    // Apply the new runtime settings to the barcode reader.
    await _barcodeReader.updateRuntimeSettings(settings: currentSettings);

    // Define the scan region.
    _cameraView.scanRegion = Region(
        regionTop: 30,
        regionLeft: 15,
        regionBottom: 70,
        regionRight: 85,
        regionMeasuredByPercentage: true);

    // Enable barcode overlay visiblity.
    _cameraView.overlayVisible = true;

    // Stream listener to handle callback when barcode result is returned.
    _barcodeReader.receiveResultStream().listen((List<BarcodeResult> res) {
      if (mounted) {
        setState(() {
          decodeRes = res;
        });
      }
    });

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
          title: Text(res.barcodeFormatString),
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
              height: 600,
              child: ListView.builder(
                itemBuilder: listItem,
                itemCount: decodeRes.length,
              ),
            ),
          ],
        ));
  }
}
