import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import '../dynamsoft_capture_vision_flutter.dart';
import 'caller/camera_enhancer_caller.dart';
import 'misc/dcv_channel_common.dart';

class DCVCameraView extends StatefulWidget {
  static CameraEnhancerCaller get _cameraEnhancerCaller =>
      CameraEnhancerCaller.instance;

  DCVCameraView({Key? key}) : super(key: key);

  // /// Set the camera whether to display the scan region on the UI.
  // ///
  // /// The [isVisible] = `true`, the scan region will be displayed on the UI.
  // /// The [isVisible] = `false`, the scan region will not be displayed.
  // set scanRegionVisible(bool isVisible) => _cameraEnhancerCaller.setScanRegionVisible(isVisible: isVisible);

  /// OverlayVisible is the property that controls whether highlighted overlays will be displayed on decoded barcodes.
  ///
  /// The [isVisible] = `true`, the overlays will be displayed.
  /// The [isVisible] = `false`, the overlays will not be displayed.
  set overlayVisible(bool isVisible) =>
      _cameraEnhancerCaller.setOverlayVisible(isVisible);

  set torchButton(TorchButton torchButton) =>
      _cameraEnhancerCaller.setTorchButton(torchButton);

  @override
  State<DCVCameraView> createState() => _DCVCameraViewState();
}

class _DCVCameraViewState extends State<DCVCameraView> {
  double width = 0;
  double height = 0;

  Widget? _embedView() {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: dynamsoftFactory,
        creationParams: {'cameraWidth': width, 'cameraHeight': height},
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: dynamsoftFactory,
        creationParams: {'cameraWidth': width, 'cameraHeight': height},
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;
      this.width = width;
      this.height = height;

      return Container(child: _embedView());
    });
  }
}
