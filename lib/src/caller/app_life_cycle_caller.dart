import '../misc/dcv_channel_common.dart';

class AppLifecycleCaller {
  static final AppLifecycleCaller _instance = AppLifecycleCaller();
  static AppLifecycleCaller get instance => _instance;

  /// View did load.
  Future<void> navigationDidPush() async{
    return await methodChannel.invokeMethod('navigation_didPush'); 
  }

  /// View dispose.
  Future<void> navigationDidPop() async{
    return await methodChannel.invokeMethod('navigation_didPop'); 
  }
  
  /// View did appear.
  Future<void> navigationDidPopNext() async{
    return await methodChannel.invokeMethod('navigation_didPopNext'); 
  }
  
  /// View did disappear.
  Future<void> navigationDidPushNext() async{
    return await methodChannel.invokeMethod('navigation_didPushNext'); 
  }

  /// Application did enter foreground.
  Future<void> appStateBecomeResumed() async{
    return await methodChannel.invokeMethod('appState_becomeResumed'); 
  }

  /// Application did enter background.
  Future<void> appStateBecomePaused() async{
    return await methodChannel.invokeMethod('appState_becomePaused'); 
  }

  /// Application will enter background.
  Future<void> appStateBecomeInactive() async{
    return await methodChannel.invokeMethod('appState_becomeInactive'); 
  }

}