import '../dbr/barcode_result.dart' show BarcodeResult;
import '../common/basic_structures.dart' show Point;

class BarcodeUtilityTool {
  static List<BarcodeResult> convertToBarcodeResults(List<Map<dynamic, dynamic>> res) {
    return res.map((e) => BarcodeResult.fromJson(e)).toList();
  }

  static List<Point> convertToPointsList(List<Map<dynamic, dynamic>> points) {
    return points.map((e) => Point.fromJson(e)).toList();
  }
}