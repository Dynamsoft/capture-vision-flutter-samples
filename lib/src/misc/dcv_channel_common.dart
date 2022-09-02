import 'package:flutter/services.dart';

const MethodChannel methodChannel = MethodChannel('com.dynamsoft/cature_vision');

const EventChannel barcodeResultEventChannel = EventChannel('com.dynamsoft/barcode_result_observer');

const String dynamsoftFactory = 'com.dynamsoft/platform_factory';