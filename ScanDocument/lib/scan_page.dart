import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';

import 'result_page.dart';
import 'main.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> with RouteAware {
  bool _isBtnClicked = false;

  //If used template is EnumPresetTemplate.detectDocumentBoundaries,
  //please add filter that is `MultiFrameResultCrossFilter()..enableResultCrossVerification(EnumCapturedResultItemType.detectedQuad.value, true)`.
  final CaptureVisionRouter _cvr = CaptureVisionRouter.instance
    ..addResultFilter(MultiFrameResultCrossFilter()..enableResultCrossVerification(EnumCapturedResultItemType.deskewedImage.value, true));
  final CameraEnhancer _camera = CameraEnhancer.instance;
  final String _template = EnumPresetTemplate.detectAndNormalizeDocument;
  late final CapturedResultReceiver _receiver = CapturedResultReceiver()
    ..onProcessedDocumentResultReceived = (ProcessedDocumentResult result) async {
      if (result.deskewedImageResultItems?.isNotEmpty ?? false) {
        var item = result.deskewedImageResultItems![0];
        if (item.crossVerificationStatus == EnumCrossVerificationStatus.passed || _isBtnClicked) {
          _isBtnClicked = false;
          final originalImage = await CaptureVisionRouter.getOriginalImage(result.originalImageHashId);
          final deskewedImage = item.imageData!;
          final sourceDeskewQuad = item.sourceDeskewQuad;
          await _cvr.stopCapturing();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                deskewedImage: deskewedImage,
                originalImage: originalImage!,
                sourceDeskewQuad: sourceDeskewQuad,
              ),
            ),
          );}
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
    _initSdk();
  }

  void _initSdk() async {
    await _cvr.setInput(_camera);
    _cvr.addResultReceiver(_receiver);
    _camera.open();
    try {
      await _cvr.startCapturing(_template);
    } catch (e) {
      _showTextDialog("StartCapturing Error", e.toString(), null);
    }
  }

  void _showTextDialog(String title, String message, VoidCallback? onDismiss) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: Text(title), content: Text(message));
      },
    ).then((_) {
      //Callback when dialog dismissed
      onDismiss?.call();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route); // register RouteAware
    }
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
    _cvr.stopCapturing();
    _camera.close();
    _cvr.removeResultReceiver(_receiver);
  }

  @override
  void didPushNext() {
    _cvr.stopCapturing();
    _camera.close();
  }

  @override
  void didPopNext() {
    _cvr.startCapturing(_template);
    _camera.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text('Scanner')),
      body: Stack(
        children: [
          CameraView(cameraEnhancer: _camera),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  _isBtnClicked = true;
                },
                style: TextButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                child: Text('Capture'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
