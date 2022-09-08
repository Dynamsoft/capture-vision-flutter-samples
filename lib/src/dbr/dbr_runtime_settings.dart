import '../misc/dcv_serializer.dart';

class DBRRuntimeSettings extends Serializer {
  int? barcodeFormatIds;
  int? barcodeFormatIds_2;
  int? expectedBarcodeCount;
  int? timeout;
  int? minBarcodeTextLength;
  int? minResultConfidence;

  DBRRuntimeSettings._();

  DBRRuntimeSettings.fromJson(Map<dynamic, dynamic> json)
      : barcodeFormatIds = json['barcodeFormatIds'],
        barcodeFormatIds_2 = json['barcodeFormatIds_2'],
        expectedBarcodeCount = json['expectedBarcodeCount'],
        timeout = json['timeout'],
        minBarcodeTextLength = json['minBarcodeTextLength'],
        minResultConfidence = json['minResultConfidence'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'barcodeFormatIds': barcodeFormatIds,
      'barcodeFormatIds_2': barcodeFormatIds_2,
      'expectedBarcodeCount': expectedBarcodeCount,
      'timeout': timeout,
      'minBarcodeTextLength': minBarcodeTextLength,
      'minResultConfidence': minResultConfidence,
    };
  }
}
