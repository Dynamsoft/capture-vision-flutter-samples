import 'package:flutter/material.dart';

import '../dbr/barcode_result.dart';
import '../dbr/dbr_runtime_settings.dart';
import '../dbr/general_enums.dart';
import '../misc/dcv_utility.dart';
import '../misc/dcv_channel_common.dart';

class BarcodeReaderCaller {
  static final BarcodeReaderCaller _instance = BarcodeReaderCaller();

  static BarcodeReaderCaller get instance => _instance;

  Future<bool> initLicense(String license) async {
    final Map jsonMap = await methodChannel
        .invokeMethod('barcodeReader_initLicense', {'license': license});

    if (jsonMap["isSuccess"] == false) {
      throw FlutterError(jsonMap["errorString"]);
    }
    return jsonMap["isSuccess"];
  }

  Future<void> createInstance() {
    return methodChannel.invokeMethod('barcodeReader_createInstance');
  }

  Future<String?> getVersion() {
    return methodChannel.invokeMethod<String>('barcodeReader_getVersion');
  }

  Future<void> startScanning() {
    return methodChannel.invokeMethod('barcodeReader_startScanning');
  }

  Future<void> stopScanning() {
    return methodChannel.invokeMethod('barcodeReader_stopScanning');
  }

  Future<void> updateRuntimeSettings(DBRRuntimeSettings settings) {
    return methodChannel.invokeMethod('barcodeReader_updateRuntimeSettings',
        {'runtimeSettings': settings.toJson()});
  }

  Future<DBRRuntimeSettings> getRuntimeSettings() async {
   final jsonMap =
        await methodChannel.invokeMethod('barcodeReader_getRuntimeSettings');
    return DBRRuntimeSettings.fromJson(Map<String, dynamic>.from(jsonMap));
  }

  Future<void> updateRuntimeSettingsFromTemplate(
      EnumDBRPresetTemplate template) {
    return methodChannel.invokeMethod(
        'barcodeReader_updateRuntimeSettingsFromTemplate',
        {'presetTemplate': template.jsonValue});
  }

  Future<void> updateRuntimeSettingsFromJson(String jsonString) {
    return methodChannel.invokeMethod(
        'barcodeReader_updateRuntimeSettingsFromJson',
        {'jsonString': jsonString});
  }

  Future<void> resetRuntimeSettings() {
    return methodChannel.invokeMethod('barcodeReader_resetRuntimeSettings');
  }

  Future<String?> outputRuntimeSettingsToString() {
    return methodChannel
        .invokeMethod<String>('barcodeReader_outputRuntimeSettingsToString');
  }

  Stream<List<BarcodeResult>> receiveResultStream() {
    return barcodeResultEventChannel.receiveBroadcastStream(
        {'streamName': 'barcodeReader_addResultlistener'}).map((event) {
      return BarcodeUtilityTool.convertToBarcodeResults(
          List<Map<dynamic, dynamic>>.from(event));
    });
  }

  Future<List<BarcodeResult>> decodeFile(String path) async {
    final list = List<Map<dynamic, dynamic>>.from(await methodChannel
        .invokeMethod('barcodeReader_decodeFile', {'flutterAssetsPath': path}));
    return BarcodeUtilityTool.convertToBarcodeResults(list);
  }

  Future enableResultVerification(bool isEnable) {
    return methodChannel.invokeMethod(
        'barcodeReader_enableResultVerification', isEnable);
  }

  Future getModeArgument(String modesName, int index, String argumentName) {
    return methodChannel.invokeMethod('barcodeReader_getModeArgument',
        {'modesName': modesName, 'index': index, 'argumentName': argumentName});
  }

  Future setModeArgument(String modesName, int index, String argumentName, String argumentValue) {
    return methodChannel.invokeMethod('barcodeReader_setModeArgument',
        {'modesName': modesName, 'index': index, 'argumentName': argumentName, 'argumentValue': argumentValue});
  }
}
