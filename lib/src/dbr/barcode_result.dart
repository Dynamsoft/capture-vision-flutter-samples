import 'package:flutter/material.dart';
import '../common/basic_structures.dart';

@immutable
class BarcodeResult {
  /// The barcode text.
  final String barcodeText;

  /// Barcode type in string.
  final String barcodeFormatString;

  /// The corresponding localization result.
  final BarcodeLocationResult barcodeLocation;

  BarcodeResult.fromJson(Map<dynamic, dynamic> json)
      : barcodeText = json['barcodeText'],
        barcodeFormatString = json['barcodeFormatString'],
        barcodeLocation = BarcodeLocationResult.fromJson(json['barcodeLocation']);
}

@immutable
class BarcodeLocationResult {
  /// The angle of a barcode. Values range from 0 to 360.
  final int angle;

  /// The coordinates of the quadrilateral points.
  final Quadrilateral location;

  BarcodeLocationResult.fromJson(Map<dynamic, dynamic> json)
      : angle = json['angle'],
        location = Quadrilateral.fromJson(json['location']);
}
