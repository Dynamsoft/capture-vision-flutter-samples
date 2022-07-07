import '../common/basic_structures.dart';
import '../misc/dcv_channel_common.dart';

class CameraEnhancerCaller {
  static final CameraEnhancerCaller _instance = CameraEnhancerCaller();
  static CameraEnhancerCaller get instance => _instance;

  Future<void> dispose() async {
    return await methodChannel.invokeMethod('cameraEnhancer_dispose');
  }

  Future<void> setScanRegion({required Region? region}) async {
    try {
      return await methodChannel.invokeMethod(
        'cameraEnhancer_setScanRegion', {'scanRegion': region?.toJson()});
    } catch (e) {
      print(e);
    }
  }

  Future<void> setScanRegionVisible({required bool isVisible}) async {
    return await methodChannel.invokeMethod(
        'cameraEnhancer_setScanRegionVisible', {'isVisible': isVisible});
  }

  Future<bool> isScanRegionVisible() async {
    return await methodChannel
        .invokeMethod('cameraEnhancer_isScanRegionVisible');
  }

  Future<void> setOverlayVisible({required bool isVisible}) async {
     return await methodChannel.invokeMethod(
        'cameraEnhancer_setOverlayVisible', {'isVisible': isVisible});
  }
}