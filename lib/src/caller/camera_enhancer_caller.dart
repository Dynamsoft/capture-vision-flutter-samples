import '../dbr/general_enums.dart';
import '../common/basic_structures.dart';
import '../misc/dcv_channel_common.dart';

class CameraEnhancerCaller {
  static final CameraEnhancerCaller _instance = CameraEnhancerCaller();

  static CameraEnhancerCaller get instance => _instance;

  Future createInstance() {
    return methodChannel.invokeMethod('cameraEnhancer_createInstance');
  }

  Future<void> dispose() {
    return methodChannel.invokeMethod('cameraEnhancer_dispose');
  }

  Future<void> setScanRegion(Region region) {
    return methodChannel.invokeMethod(
        'cameraEnhancer_setScanRegion', {'scanRegion': region.toJson()});
  }

  Future<void> setScanRegionVisible({required bool isVisible}) {
    return methodChannel.invokeMethod(
        'cameraEnhancer_setScanRegionVisible', {'isVisible': isVisible});
  }

  Future<void> setOverlayVisible(bool isVisible) {
    return methodChannel.invokeMethod(
        'cameraEnhancer_setOverlayVisible', {'isVisible': isVisible});
  }

  Future<void> openCamera() {
    return methodChannel.invokeMethod("cameraEnhancer_openCamera");
  }

  Future<void> closeCamera() {
    return methodChannel.invokeMethod("cameraEnhancer_closeCamera");
  }

  Future selectCamera(EnumCameraPosition position) {
    return methodChannel.invokeMethod("cameraEnhancer_selectCamera",
        position == EnumCameraPosition.CP_BACK ? 0 : 1);
  }

  Future turnOnTorch() {
    return methodChannel.invokeMethod("cameraEnhancer_turnOnTorch");
  }

  Future turnOffTorch() {
    return methodChannel.invokeMethod("cameraEnhancer_turnOffTorch");
  }

  Future setTorchButton(TorchButton button) {
    return methodChannel.invokeMethod("cameraView_torchButton", button.toJson());
  }
}
