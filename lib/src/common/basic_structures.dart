import '../misc/dcv_utility.dart';
import '../misc/dcv_serializer.dart';

/// Describes the scan region of the camera.
///
/// When [regionMeasuredByPercentage] set to true, the values of Top, Left, Right, Bottom indicate the percentage (from 0 to 100); otherwise, they refer to the coordinates.
class Region extends Serializer {
  int regionTop;
  int regionBottom;
  int regionLeft;
  int regionRight;
  bool regionMeasuredByPercentage;

  Region({required this.regionTop,
          required this.regionBottom,
          required this.regionLeft,
          required this.regionRight,
          required this.regionMeasuredByPercentage});

  @override
  Map<String, dynamic> toJson() {
    return {
      'regionTop': regionTop,
      'regionBottom': regionBottom,
      'regionLeft': regionLeft,
      'regionRight': regionRight,
      'regionMeasuredByPercentage': regionMeasuredByPercentage
    };
  }
}


class Quadrilateral {
  List<Point> points;

  Quadrilateral.fromJson(Map<dynamic, dynamic> json)
      : points = BarcodeUtilityTool.convertToPointsList(List<Map<dynamic, dynamic>>.from(json['pointsList']));
}

class Point {
  int x;
  int y;

  Point.fromJson(Map<dynamic, dynamic> json)
      : x = json['x'],
        y = json['y'];
}
