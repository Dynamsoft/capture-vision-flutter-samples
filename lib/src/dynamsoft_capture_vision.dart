import 'caller/app_route_observer.dart';
import 'package:flutter/material.dart';

class DynamsoftCaptureVision {
  /// Add an observer for Dynamsoft plugin.
  /// Please register this method in your App.
  ///
  /// You can use [routeObserver] like this:
  /// ```
  /// @override
  /// Widget build(BuildContext context) {
  ///   return MaterialApp(
  ///     navigatorObservers:[
  ///       DynamsoftCaptureVision.routeObserver
  ///     ],
  ///   );
  /// }
  /// ```
  static RouteObserver<ModalRoute<void>> get routeObserver {
    return AppRouteObserver().routeObserver;
  }
}