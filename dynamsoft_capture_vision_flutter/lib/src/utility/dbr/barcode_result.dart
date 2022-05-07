import 'package:flutter/material.dart';

@immutable
class BarcodeResult {
  /// The barcode text.
  final String barcodeText;

  /// Barcode type in string.
  final String barcodeFormatString;

  /// The corresponding localization result.
  final BarcodeLocationResult barcodeLocation;

  BarcodeResult.fromJson(Map<dynamic, dynamic>json): 
    this.barcodeText = json['barcodeText'],
    this.barcodeFormatString = json['barcodeFormatString'],
    this.barcodeLocation = BarcodeLocationResult.fromJson(json['barcodeLocation']);

}

List<BarcodeResult> convertToTextResults(List<Map<dynamic, dynamic>> res) {
  return res.map((e) => BarcodeResult.fromJson(e)).toList();
}

@immutable
class BarcodeLocationResult {
  /// The angle of a barcode. Values range from 0 to 360.
  final int angle;

  /// The coordinates of the quadrilateral points.
  final Quadrilateral location;

  BarcodeLocationResult.fromJson(Map<dynamic, dynamic>json):
  this.angle = json['angle'],
  this.location = Quadrilateral.fromJson(json['location']);
}

@immutable
class Quadrilateral {
  final List<Point> points;

  Quadrilateral.fromJson(Map<dynamic, dynamic>json) :
  this.points = convertToPointsList(List<Map<dynamic, dynamic>>.from(json['pointsList']));
}

@immutable
class Point {
  final int x;
  final int y;
  
  Point.fromJson(Map<dynamic, dynamic>json):
  this.x = json['x'],
  this.y = json['y'];
}

List<Point> convertToPointsList(List<Map<dynamic, dynamic>> points) {
  return points.map((e) => Point.fromJson(e)).toList();
}


