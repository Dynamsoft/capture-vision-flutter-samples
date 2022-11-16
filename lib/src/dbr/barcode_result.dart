import 'dart:convert';
import 'dart:typed_data';

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

  final String _barcodeBytesString;

  Uint8List get barcodeBytes {
    final base64Decoder = base64.decoder;
    final decodedBytes = base64Decoder.convert(_barcodeBytesString);
    print('_barcodeBytesString:$_barcodeBytesString');
    return decodedBytes;
  }

  BarcodeResult.fromJson(Map<dynamic, dynamic> json)
      : barcodeText = json['barcodeText'],
        barcodeFormatString = json['barcodeFormatString'],
        _barcodeBytesString = json['barcodeBytesString'],
        barcodeLocation =
            BarcodeLocationResult.fromJson(json['barcodeLocation']);
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
