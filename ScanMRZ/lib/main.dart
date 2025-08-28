import 'package:dynamsoft_mrz_scanner_bundle_flutter/dynamsoft_mrz_scanner_bundle_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scan MRZ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const MyHomePage(title: 'Scan MRZ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _displayString = "";

  void _launchMrzScanner() async {
    var config = MRZScannerConfig(
      license: "DLS2eyJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSJ9",
    );
    MRZScanResult mrzScanResult = await MRZScanner.launch(config);

    setState(() {
      if(mrzScanResult.status == EnumResultStatus.canceled) {
        _displayString = "Scan canceled";
      } else if(mrzScanResult.status == EnumResultStatus.exception) {
        _displayString = "ErrorCode: ${mrzScanResult.errorCode}\n\nErrorString: ${mrzScanResult.errorMessage}";
      } else { //EnumResultStatus.finished
        MRZData data = mrzScanResult.mrzData!;
        _displayString = "Name:\t${data.firstName} ${data.lastName}\n\n"
            "Sex: ${data.sex.substring(0,1).toUpperCase() + data.sex.substring(1)}\n\n"
            "Age: ${data.age}\n\n"
            "Document Type: ${data.documentType}\n\n"
            "Document Number: ${data.documentNumber}\n\n"
            "Issuing State: ${data.issuingState}\n\n"
            "Nationality: ${data.nationality}\n\n"
            "Date of Birth(YYYY-MM-DD): ${data.dateOfBirth}\n\n"
            "Date of Expiry(YYYY-MM-DD): ${data.dateOfExpire}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _displayString,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20), // Add a spacing of 20
              TextButton(
                onPressed: _launchMrzScanner,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Scan an MRZ"),
              ),
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
