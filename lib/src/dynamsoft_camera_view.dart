import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'caller/app_life_cycle_caller.dart';
import 'caller/app_route_observer.dart';
import 'caller/camera_enhancer_caller.dart';
import 'common/basic_structures.dart';
import 'misc/dcv_channel_common.dart';


class DynamsoftCameraView extends StatefulWidget {
  static CameraEnhancerCaller get _cameraEnhancerCaller => CameraEnhancerCaller.instance;

  static AppLifecycleCaller get _appLifecycleCaller => AppLifecycleCaller.instance;

  DynamsoftCameraView({Key? key}) : super(key: key);

  /// Specify a scan region for the camera. The video frames will be cropped based on the scan region.
  ///
  /// The [region] is a Region value that refers to the scan region setting.
  /// You can also input `null` to make the scan region restore to default, this will make the scan region full the area that you specify.
  ///
  /// You can use [scanRegion] like this:
  ///
  /// ```
  /// final DynamsoftCameraView _cameraView = DynamsoftCameraView();
  /// Region scanRegion = Region(regionTop: 20, regionBottom: 80, regionLeft: 20, regionRight: 80, regionMeasuredByPercentage: true);
  /// _cameraView.scanRegion = scanRegion;
  /// ```
  set scanRegion(Region? region) => _cameraEnhancerCaller.setScanRegion(region: region);

  /// Set the camera whether to display the scan region on the UI.
  ///
  /// The [isVisible] = `true`, the scan region will be displayed on the UI.
  /// The [isVisible] = `false`, the scan region will not be displayed.
  set scanRegionVisible(bool isVisible) => _cameraEnhancerCaller.setScanRegionVisible(isVisible: isVisible);

  /// OverlayVisible is the property that controls whether highlighted overlays will be displayed on decoded barcodes.
  ///
  /// The [isVisible] = `true`, the overlays will be displayed.
  /// The [isVisible] = `false`, the overlays will not be displayed.
  set overlayVisible(bool isVisible) =>
      _cameraEnhancerCaller.setOverlayVisible(isVisible: isVisible);

  /// Open the camera.
  Future<void> openCamera() => _cameraEnhancerCaller.openCamera();

  /// Close the camera.
  Future<void> closeCamera() => _cameraEnhancerCaller.closeCamera();

  @override
  State<DynamsoftCameraView> createState() => _DynamsoftCameraViewState();
}

class _DynamsoftCameraViewState extends State<DynamsoftCameraView>
    with WidgetsBindingObserver, RouteAware {
  double width = 0;
  double height = 0;

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    AppRouteObserver().routeObserver.unsubscribe(this);
    DynamsoftCameraView._cameraEnhancerCaller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (Platform.isAndroid) {
      if (state == AppLifecycleState.inactive) {
        DynamsoftCameraView._appLifecycleCaller.appStateBecomeInactive();
      } else if (state == AppLifecycleState.resumed) {
        DynamsoftCameraView._appLifecycleCaller.appStateBecomeResumed();
      }
    }
  }

  @override
  void didPopNext() {
    super.didPopNext();
    DynamsoftCameraView._appLifecycleCaller.navigationDidPopNext();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    DynamsoftCameraView._appLifecycleCaller.navigationDidPushNext();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  Widget? _embedView() {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: dynamsoftFactory,
        creationParams: {
          'cameraWidth': width,
          'cameraHeight': height
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (Platform.isAndroid) {
      return AndroidView(
        viewType: dynamsoftFactory,
        creationParams: {
          'cameraWidth': width,
          'cameraHeight': height
        },
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
