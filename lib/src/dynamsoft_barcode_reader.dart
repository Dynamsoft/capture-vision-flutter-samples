import 'package:flutter/services.dart';

import 'caller/barcode_reader_caller.dart';
import 'utility/dbr/dbr_runtime_settings.dart';
import 'utility/general_enums.dart';
import 'utility/dbr/barcode_result.dart';

/// Defines a class that provides functions for working with extracting barcode data.
///
/// You should invoke [createInstance] to create an instance.
class DynamsoftBarcodeReader {
  DynamsoftBarcodeReader._();

  static BarcodeReaderCaller get _barcodeReaderCaller =>
      BarcodeReaderCaller.instance;

  static DynamsoftBarcodeReader _barcodeReader = DynamsoftBarcodeReader._();

  /// Initializes the barcode reader license and connects to the specified server for online verification.
  ///
  /// The [license] is a key. It can be online/offline, trial/full.
  ///
  /// Return `true` is vertify success, otherwise return `false`.
  ///
  /// You can use [initLicense] like this:
  ///
  /// ```
  /// await DynamsoftBarcodeReader.initLicense(license: '*********');
  /// ```
  static Future<bool> initLicense({required String license}) {
    return _barcodeReaderCaller.initLicense(license: license);
  }

  /// Create an instance of DynamsoftBarcodeReader.
  ///
  /// You can use [createInstance] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// ```
  static Future<DynamsoftBarcodeReader> createInstance() async {
    await _barcodeReaderCaller.createInstance();
    return _barcodeReader;
  }

  /// Returns the version info of the internal SDK.
  ///
  /// You can use [getVersion] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// String dbrVersion = await _barcodeReader.getVersion();
  /// ```
  Future<String?> getVersion() {
    return _barcodeReaderCaller.getVersion();
  }

  /// Start the video streaming barcode decoding thread.
  ///
  /// You can use [startScanning] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// await _barcodeReader.startScanning();
  /// ```
  Future<void> startScanning() {
    return _barcodeReaderCaller.startScanning();
  }

  /// Stop the video streaming barcode decoding thread.
  ///
  /// You can use [stopScanning] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// await _barcodeReader.stopScanning();
  /// ```
  Future<void> stopScanning() {
    return _barcodeReaderCaller.stopScanning();
  }

  /// Gets current settings
  ///
  /// The method will throw [PlatformException] if an error occurs when updateBarcodeSettings operation.
  /// You can use [getRuntimeSettings] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// try {
  ///  DBRRuntimeSettings currentSettings = await _barcodeReader.getRuntimeSettings();
  /// } catch (e) {
  ///   print('error = $e');
  /// }
  /// ```
  Future<DBRRuntimeSettings> getRuntimeSettings() {
    return _barcodeReaderCaller.getRuntimeSettings();
  }

  /// Update runtime settings with a given BarcodeSettings.
  ///
  /// The method will throw [PlatformException] if an error occurs when updateBarcodeSettings operation.
  /// The [DBRRuntimeSettings] argument must not be null.
  ///
  /// You can use [updateRuntimeSettings] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// DBRRuntimeSettings settings = DBRRuntimeSettings();
  /// settings.barcodeFormatIds = EnumBarcodeFormat.BF_ALL;
  /// settings.barcodeFormatIds_2 = EnumBarcodeFormat_2.BF2_NULL;
  /// settings.expectedBarcodeCount = 0;
  ///  settings.timeout = 5000;
  /// try {
  ///   await _barcodeReader.updateRuntimeSettings(settings: settings);
  /// } catch (e) {
  ///   print('error = $e');
  /// }
  /// ```
  Future<void> updateRuntimeSettings({required DBRRuntimeSettings settings}) {
    return _barcodeReaderCaller.updateRuntimeSettings(settings: settings);
  }

  /// Update the runtime settings from a preset template.
  ///
  /// The [EnumDBRPresetTemplate] argument must not be null.
  ///
  /// You can use [updateRuntimeSettingsFromTemplate] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// await _barcodeReader.updateRuntimeSettingsFromTemplate(template: EnumDBRPresetTemplate.DEFAULT);
  /// ```
  Future<void> updateRuntimeSettingsFromTemplate({required EnumDBRPresetTemplate template}) {
    return _barcodeReaderCaller.updateRuntimeSettingsFromTemplate(template: template);
  }

  /// Update runtime settings with the given JSON string.
  ///
  /// The method will throw [PlatformException] if an error occurs when updateBarcodeSettingsFromJson operation.
  ///
  /// The [jsonString] is a string that represents the content of the settings and must not be null.
  ///
  /// You can use [updateRuntimeSettingsFromJson] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// try {
  ///   await _barcodeReader.updateRuntimeSettingsFromJson(jsonString: '**********');
  /// } catch (e) {
  ///   print('error = $e');
  /// }
  /// ```
  Future<void> updateRuntimeSettingsFromJson({required String jsonString}) {
    return _barcodeReaderCaller.updateRuntimeSettingsFromJson(jsonString: jsonString);
  }

  /// Resets all parameters to default values.
  ///
  /// The method will throw [PlatformException] if an error occurs when resetBarcodeSettings operation.
  ///
  /// You can use [resetRuntimeSettings] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// try {
  ///   await _barcodeReader.resetRuntimeSettings();
  /// } catch (e) {
  ///   print('error = $e');
  /// }
  /// ```
  Future<void> resetRuntimeSettings() {
    return _barcodeReaderCaller.resetRuntimeSettings();
  }

  /// Outputs runtime settings to a string.
  ///
  /// The method will throw [PlatformException] if an error occurs when outputBarcodeSettings operation.
  ///
  /// You can use [outputRuntimeSettingsToString] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// try {
  ///   String settingString = await _barcodeReader.outputRuntimeSettingsToString();
  /// } catch (e) {
  ///   print('error = $e');
  /// }
  /// ```
  Future<String?> outputRuntimeSettingsToString() {
    return _barcodeReaderCaller.outputRuntimeSettingsToString();
  }

   /// Obtain the barcode results from the callback.
  ///
  /// You can use this method to listen all the barcode results of the camera's capture.
  ///
  /// You can use [receiveBarcodeResultStream] like this:
  ///
  /// ```
  /// late final DynamsoftBarcodeReader _barcodeReader;
  /// await DynamsoftBarcodeReader.initLicense(license: '**********');
  /// _barcodeReader = await DynamsoftBarcodeReader.createInstance();
  /// _barcodeReader.startScanning();
  /// _barcodeReader.receiveBarcodeResultStream().listen((List<TextResult> res) {});
  /// ```
  Stream<List<BarcodeResult>> receiveBarcodeResultStream() {
    return _barcodeReaderCaller.receiveBarcodeResultStream();
  }
}
