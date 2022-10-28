/// Describes the PresetTemplate.
enum EnumDBRPresetTemplate {
  DEFAULT,
  VIDEO_SINGLE_BARCODE,
  VIDEO_SPEED_FIRST,
  VIDEO_READ_RATE_FIRST,
  IMAGE_SPEED_FIRST,
  IMAGE_READ_RATE_FIRST,
  IMAGE_DEFAULT
}

enum EnumCameraPosition {
  CP_BACK,
  CP_FRONT
}

extension PresetTemplateSerializer on EnumDBRPresetTemplate {
  EnumDBRPresetTemplate fromJson(String? jsonValue) {
    switch (jsonValue) {
      case 'default':
        return EnumDBRPresetTemplate.DEFAULT;
      case 'videoSingleBarcode':
        return EnumDBRPresetTemplate.VIDEO_SINGLE_BARCODE;
      case 'videoSpeedFirst':
        return EnumDBRPresetTemplate.VIDEO_SPEED_FIRST;
      case 'videoReadRateFirst':
        return EnumDBRPresetTemplate.VIDEO_READ_RATE_FIRST;
      case 'imageSpeedFirst':
        return EnumDBRPresetTemplate.IMAGE_SPEED_FIRST;
      case 'imageReadRateFirst':
        return EnumDBRPresetTemplate.IMAGE_READ_RATE_FIRST;
      case 'imageDefault':
        return EnumDBRPresetTemplate.IMAGE_DEFAULT;  
      default:
        throw Exception("Missing PresetTemplate for '$jsonValue'");
    }
  }

  String get jsonValue => _jsonValue();
  String _jsonValue() {
    switch (this) {
      case EnumDBRPresetTemplate.DEFAULT:
        return 'default';
      case EnumDBRPresetTemplate.VIDEO_SINGLE_BARCODE:
        return 'videoSingleBarcode';
      case EnumDBRPresetTemplate.VIDEO_SPEED_FIRST:
        return 'videoSpeedFirst';
      case EnumDBRPresetTemplate.VIDEO_READ_RATE_FIRST:
        return 'videoReadRateFirst';
      case EnumDBRPresetTemplate.IMAGE_SPEED_FIRST:
        return 'imageSpeedFirst';
      case EnumDBRPresetTemplate.IMAGE_READ_RATE_FIRST:
        return 'imageReadRateFirst';
      case EnumDBRPresetTemplate.IMAGE_DEFAULT:
        return 'imageDefault';  
      default:
        throw Exception("Missing Json Value for '$this' PresetTemplate");
    }
  }
}

class EnumBinarizationMode{
  static const int BM_SKIP = 0;
  static const int BM_AUTO = 1;
  static const int BM_LOCAL_BLOCK = 2;
  static const int BM_THRESHOLD = 4;
}

class EnumDeblurMode{
  static const int DM_SKIP = 0;
  static const int DM_DIRECT_BINARIZATION = 1;
  static const int DM_THRESHOLD_BINARIZATION = 2;
  static const int DM_GRAYE_EQULIZATION = 4;
  static const int DM_SMOOTHING = 8;
  static const int DM_MORPHING = 16;
  static const int DM_DEEP_ANALYSIS = 32;
  static const int DM_SHARPENING = 64;
  static const int DM_BASED_ON_LOC_BIN = 128;
  static const int DM_SHARPENING_SMOOTHING = 256;
}

class EnumLocalizationMode{
  static const int LM_SKIP = 0;
  static const int LM_AUTO = 1;
  static const int LM_CONNECTED_BLOCKS = 2;
  static const int LM_STATISTICS = 4;
  static const int LM_LINES = 8;
  static const int LM_SCAN_DIRECTLY = 16;
  static const int LM_STATISTICS_MARKS = 32;
  static const int LM_STATISTICS_POSTAL_CODE = 64;
  static const int LM_CENTRE = 128;
  static const int LM_ONED_FAST_SCAN = 256;
}

class EnumScaleUpMode{
  static const int SUM_SKIP = 0;
  static const int SUM_AUTO = 1;
  static const int SUM_LINEAR_INTERPOLATION = 2;
  static const int SUM_NEAREST_NEIGHBOUR_INTERPOLATION = 4;
}

class EnumTextResultOrderMode{
  static const int TROM_SKIP = 0;
  static const int TROM_CONFIDENCE = 1;
  static const int TROM_POSITION = 2;
  static const int TROM_FORMAT = 4;
}

class EnumGrayscaleTransformationMode{
  static const int GTM_SKIP = 0;
  static const int GTM_INVERTED = 1;
  static const int GTM_ORIGINAL = 2;
}

class EnumDPMCodeReadingMode{
  static const int DPMCRM_SKIP = 0;
  static const int DPMCRM_AUTO= 1;
  static const int DPMCRM_GENERAL = 2;
}

class EnumRegionPredetectionMode{
  static const int RPM_SKIP = 0;
  static const int RPM_AUTO = 1;
  static const int RPM_GENERAL = 2;
  static const int RPM_GENERAL_RGB_CONTRAST = 4;
  static const int RPM_GENERAL_GRAY_CONTRAST = 8;
  static const int RPM_GENERAL_HSV_CONTRAST = 16;
}
