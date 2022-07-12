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

