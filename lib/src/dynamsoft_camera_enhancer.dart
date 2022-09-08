import '../dynamsoft_capture_vision_flutter.dart';
import 'caller/camera_enhancer_caller.dart';

class DCVCameraEnhancer {
  static CameraEnhancerCaller get _cameraEnhancerCaller =>
      CameraEnhancerCaller.instance;

  DCVCameraEnhancer._();

  static final DCVCameraEnhancer _cameraEnhancer = DCVCameraEnhancer._();

  static Future<DCVCameraEnhancer> createInstance() async {
    await _cameraEnhancerCaller.createInstance();
    return _cameraEnhancer;
  }

  Future open(){
    return _cameraEnhancerCaller.openCamera();
  }

  Future close(){
    return _cameraEnhancerCaller.closeCamera();
  }

  Future selectCamera(EnumCameraPosition position){
    return _cameraEnhancerCaller.selectCamera(position);
  }

  Future turnOnTorch(){
    return _cameraEnhancerCaller.turnOnTorch();
  }

  Future turnOffTorch(){
    return _cameraEnhancerCaller.turnOffTorch();
  }

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
  Future setScanRegion(Region scanRegion){
    return _cameraEnhancerCaller.setScanRegion(scanRegion);
  }
}

