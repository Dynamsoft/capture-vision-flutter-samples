import 'barcode_formats.dart';
import '../common.dart';

class DBRRuntimeSettings extends Serializer{

  int barcodeFormatIds;
  int barcodeFormatIds_2;
  int expectedBarcodeCount;
  int timeout;

  DBRRuntimeSettings({
    this.barcodeFormatIds = EnumBarcodeFormat.BF_ALL,
    this.barcodeFormatIds_2 = EnumBarcodeFormat_2.BF2_NULL,
    this.expectedBarcodeCount = 0,
    this.timeout = 5000
    });
  
  DBRRuntimeSettings.fromJson(Map<dynamic, dynamic> json):
  this.barcodeFormatIds = json['barcodeFormatIds'],
  this.barcodeFormatIds_2 = json['barcodeFormatIds_2'],
  this.expectedBarcodeCount = json['expectedBarcodeCount'],
  this.timeout = json['timeout'];

  @override
  Map<String, dynamic> toJson() {
    return {'barcodeFormatIds':this.barcodeFormatIds,
            'barcodeFormatIds_2':this.barcodeFormatIds_2,
            'expectedBarcodeCount':this.expectedBarcodeCount,
            'timeout':this.timeout
    };
  }
  
}