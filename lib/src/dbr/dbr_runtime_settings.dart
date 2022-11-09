import '../common/basic_structures.dart';
import '../misc/dcv_serializer.dart';

class DBRRuntimeSettings extends Serializer {
  int? barcodeFormatIds;
  int? barcodeFormatIds_2;
  int? expectedBarcodeCount;
  int? timeout;
  int? minBarcodeTextLength;
  int? minResultConfidence;
  List<int>? binarizationModes;
  List<int>? deblurModes;
  List<int>? localizationModes;
  List<int>? scaleUpModes;
  List<int>? textResultOrderModes;
  int? deblurLevel;
  int? scaleDownThreshold;
  Region? region;
  FurtherModes? furtherModes;

  DBRRuntimeSettings._();

  DBRRuntimeSettings.fromJson(Map<String, dynamic> json) {
    barcodeFormatIds = json['barcodeFormatIds'];
    barcodeFormatIds_2 = json['barcodeFormatIds_2'];
    expectedBarcodeCount = json['expectedBarcodeCount'];
    timeout = json['timeout'];
    minBarcodeTextLength = json['minBarcodeTextLength'];
    minResultConfidence = json['minResultConfidence'];
    binarizationModes = List<int>.from(json['binarizationModes']);
    deblurModes = List<int>.from(json['deblurModes']);
    deblurLevel = json['deblurLevel'];
    localizationModes = List<int>.from(json['localizationModes']);
    scaleDownThreshold = json['scaleDownThreshold'];
    scaleUpModes = List<int>.from(json['scaleUpModes']);
    textResultOrderModes = List<int>.from(json['textResultOrderModes']);
    region = json['region'] != null
        ? new Region.fromJson(Map<String, dynamic>.from(json['region']))
        : null;
    furtherModes = json['furtherModes'] != null
        ? new FurtherModes.fromJson(
            Map<String, dynamic>.from(json['furtherModes']))
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['barcodeFormatIds'] = this.barcodeFormatIds;
    data['barcodeFormatIds_2'] = this.barcodeFormatIds_2;
    data['expectedBarcodeCount'] = this.expectedBarcodeCount;
    data['timeout'] = this.timeout;
    data['minBarcodeTextLength'] = this.minBarcodeTextLength;
    data['minResultConfidence'] = this.minResultConfidence;
    data['binarizationModes'] = this.binarizationModes;
    data['deblurModes'] = this.deblurModes;
    data['deblurLevel'] = this.deblurLevel;
    data['localizationModes'] = this.localizationModes;
    data['scaleDownThreshold'] = this.scaleDownThreshold;
    data['scaleUpModes'] = this.scaleUpModes;
    data['textResultOrderModes'] = this.textResultOrderModes;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.furtherModes != null) {
      data['furtherModes'] = this.furtherModes!.toJson();
    }

    return data;
  }
}
