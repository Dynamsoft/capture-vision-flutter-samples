import '../common/basic_structures.dart';
import '../misc/dcv_channel_common.dart';

class CameraEnhancerCaller {
  static final CameraEnhancerCaller _instance = CameraEnhancerCaller();
  static CameraEnhancerCaller get instance => _instance;

  Future<void> dispose() {
    return methodChannel.invokeMethod('cameraEnhancer_dispose');
  }

  Future<void> setScanRegion({required Region? region}) {
    return methodChannel.invokeMethod('cameraEnhancer_setScanRegion', {'scanRegion': region?.toJson()});
  }

  Future<void> setScanRegionVisible({required bool isVisible}) {
    return methodChannel.invokeMethod('cameraEnhancer_setScanRegionVisible', {'isVisible': isVisible});
  }

  Future<void> setOverlayVisible({required bool isVisible}) {
     return methodChannel.invokeMethod('cameraEnhancer_setOverlayVisible', {'isVisible': isVisible});
  }
  
  Future<void> openCamera() {
    return methodChannel.invokeMethod("cameraEnhancer_openCamera");
  }

  Future<void> closeCamera() {
    return methodChannel.invokeMethod("cameraEnhancer_closeCamera");
  }
}