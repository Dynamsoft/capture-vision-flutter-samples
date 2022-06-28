import '../common.dart';

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
          required this.regionMeasuredByPercentage})
      : assert(regionTop > 0 && regionTop < 100),
        assert(regionBottom > 0 && regionBottom < 100),
        assert(regionLeft > 0 && regionLeft < 100),
        assert(regionRight > 0 && regionRight < 100);

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
