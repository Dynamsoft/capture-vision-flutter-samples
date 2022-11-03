import '../misc/dcv_utility.dart';
import '../misc/dcv_serializer.dart';

/// Describes the scan region of the camera.
///
/// When [regionMeasuredByPercentage] set to true, the values of Top, Left, Right, Bottom indicate the percentage (from 0 to 100); otherwise, they refer to the coordinates.
class Region extends Serializer {
  int? regionTop;
  int? regionBottom;
  int? regionLeft;
  int? regionRight;
  int? regionMeasuredByPercentage;

  Region(
      {required this.regionTop,
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

  Region.fromJson(Map<String, dynamic> json) {
    regionTop = json['regionTop'];
    regionBottom = json['regionBottom'];
    regionLeft = json['regionLeft'];
    regionRight = json['regionRight'];
    regionMeasuredByPercentage = json['regionMeasuredByPercentage'];
  }
}

class Quadrilateral {
  List<Point> points;

  Quadrilateral.fromJson(Map<dynamic, dynamic> json)
      : points = BarcodeUtilityTool.convertToPointsList(
            List<Map<dynamic, dynamic>>.from(json['pointsList']));
}

class Point {
  int x;
  int y;

  Point.fromJson(Map<dynamic, dynamic> json)
      : x = json['x'],
        y = json['y'];
}

class TorchButton {
  Rect? rect;
  bool? visible;
  String? torchOnImage;
  String? torchOffImage;

  TorchButton({this.rect, this.visible, this.torchOnImage, this.torchOffImage});

  TorchButton.fromJson(Map<String, dynamic> json) {
    rect = json['rect'] != null ? new Rect.fromJson(json['rect']) : null;
    visible = json['visible'];
    torchOnImage = json['torchOnImage'];
    torchOffImage = json['torchOffImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rect != null) {
      data['rect'] = this.rect!.toJson();
    }
    data['visible'] = this.visible;
    data['torchOnImage'] = this.torchOnImage;
    data['torchOffImage'] = this.torchOffImage;
    return data;
  }
}

class Rect {
  int? x;
  int? y;
  int? width;
  int? height;

  Rect({this.x, this.y, this.width, this.height});

  Rect.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class FurtherModes {
  List<int>? colourClusteringModes;
  List<int>? colourConversionModes;
  List<int>? grayscaleTransformationModes;
  List<int>? regionPredetectionModes;
  List<int>? imagePreprocessingModes;
  List<int>? textureDetectionModes;
  List<int>? textFilterModes;
  List<int>? dpmCodeReadingModes;
  List<int>? deformationResistingModes;
  List<int>? barcodeComplementModes;
  List<int>? barcodeColourModes;

  FurtherModes(
      {this.colourClusteringModes,
      this.colourConversionModes,
      this.grayscaleTransformationModes,
      this.regionPredetectionModes,
      this.imagePreprocessingModes,
      this.textureDetectionModes,
      this.textFilterModes,
      this.dpmCodeReadingModes,
      this.deformationResistingModes,
      this.barcodeComplementModes,
      this.barcodeColourModes,});

  FurtherModes.fromJson(Map<String, dynamic> json) {
    colourClusteringModes = List<int>.from(json['colourClusteringModes']);
    colourConversionModes = List<int>.from(json['colourConversionModes']);
    grayscaleTransformationModes = List<int>.from(json['grayscaleTransformationModes']);
    regionPredetectionModes = List<int>.from(json['regionPredetectionModes']);
    imagePreprocessingModes = List<int>.from(json['imagePreprocessingModes']);
    textureDetectionModes = List<int>.from(json['textureDetectionModes']);
    textFilterModes = List<int>.from(json['textFilterModes']);
    dpmCodeReadingModes = List<int>.from(json['dpmCodeReadingModes']);
    deformationResistingModes = List<int>.from(json['deformationResistingModes']);
    barcodeComplementModes = List<int>.from(json['barcodeComplementModes']);
    barcodeColourModes = List<int>.from(json['barcodeColourModes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colourClusteringModes'] = this.colourClusteringModes;
    data['colourConversionModes'] = this.colourConversionModes;
    data['grayscaleTransformationModes'] = this.grayscaleTransformationModes;
    data['regionPredetectionModes'] = this.regionPredetectionModes;
    data['imagePreprocessingModes'] = this.imagePreprocessingModes;
    data['textureDetectionModes'] = this.textureDetectionModes;
    data['textFilterModes'] = this.textFilterModes;
    data['dpmCodeReadingModes'] = this.dpmCodeReadingModes;
    data['deformationResistingModes'] = this.deformationResistingModes;
    data['barcodeComplementModes'] = this.barcodeComplementModes;
    data['barcodeColourModes'] = this.barcodeColourModes;
    return data;
  }
}
