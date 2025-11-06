import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';

import 'vin_scan_result.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with RouteAware {
  final CaptureVisionRouter _cvr = CaptureVisionRouter.instance
    ..addResultFilter(
      MultiFrameResultCrossFilter()..enableResultCrossVerification(EnumCapturedResultItemType.textLine.value | EnumCapturedResultItemType.barcode.value, true),
    );
  final CameraEnhancer _camera = CameraEnhancer.instance;
  final String _templateName = "ReadVIN";
  late final CapturedResultReceiver _receiver = CapturedResultReceiver()
    ..onParsedResultsReceived = (ParsedResult result) async {
      if (result.items?.isNotEmpty ?? false) {
        _cvr.stopCapturing();
        VINData? data;
        if (result.items!.length == 1) {
          data = VINData.fromParsedResultItem(result.items![0]);
        } else {
          // result.items!.length>1
          for (var item in result.items!) {
            if (item.targetROIDefName.contains('vin-barcode')) {
              //Means this item is pared from a barcode, which is more accurate than textLine.
              data = VINData.fromParsedResultItem(item);
              break;
            }
          }
        }
        if (data != null) {
          final scanResult = VINScanResult(resultStatus: EnumResultStatus.finished, data: data);
          Navigator.pop(context, scanResult);
        } else {
          _cvr.startCapturing(_templateName); // restart capturing
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
    await _cvr.setInput(_camera);
    _camera.setScanRegion(DSRect(left: 0.1, top: 0.4, right: 0.9, bottom: 0.6, measuredInPercentage: true));
    _cvr.addResultReceiver(_receiver);
    _camera.open();
    try {
      await _cvr.startCapturing(_templateName);
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(VINScanResult(resultStatus: EnumResultStatus.error, errorString: e.toString()));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cvr.stopCapturing();
    _camera.close();
    _cvr.removeResultReceiver(_receiver);
    _cvr.removeAllResultFilters();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? _) {
        if (didPop) {
          return;
        }
        final scanResult = VINScanResult(resultStatus: EnumResultStatus.cancelled);
        Navigator.pop(context, scanResult);
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text("Scanner")),
        body: Stack(
          children: [Center(child: CameraView(cameraEnhancer: _camera))],
        ),
      ),
    );
  }
}
