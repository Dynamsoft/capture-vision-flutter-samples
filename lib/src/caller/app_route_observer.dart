import 'package:flutter/material.dart';

class AppRouteObserver {

  static final RouteObserver<ModalRoute<void>> _routeObserver =
      RouteObserver<ModalRoute<void>>();

  static final AppRouteObserver _appRouteObserver =
      AppRouteObserver._internal();

  AppRouteObserver._internal();

  RouteObserver<ModalRoute<void>> get routeObserver {
    return _routeObserver;
  }

  factory AppRouteObserver() {
    return _appRouteObserver;
  }
}