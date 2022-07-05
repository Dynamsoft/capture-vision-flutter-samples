/// Describes the PresetTemplate.
enum EnumDBRPresetTemplate {
  videoDefault,
  videoSingleBarcode,
  videoSpeedFirst,
  videoReadRateFirst,
  imageSpeedFirst,
  imageReadRateFirst,
  imageDefault
}

extension PresetTemplateSerializer on EnumDBRPresetTemplate {
  EnumDBRPresetTemplate fromJson(String? jsonValue) {
    switch (jsonValue) {
      case 'default':
        return EnumDBRPresetTemplate.videoDefault;
      case 'videoSingleBarcode':
        return EnumDBRPresetTemplate.videoSingleBarcode;
      case 'videoSpeedFirst':
        return EnumDBRPresetTemplate.videoSpeedFirst;
      case 'videoReadRateFirst':
        return EnumDBRPresetTemplate.videoReadRateFirst;
      case 'imageSpeedFirst':
        return EnumDBRPresetTemplate.imageSpeedFirst;
      case 'imageReadRateFirst':
        return EnumDBRPresetTemplate.imageReadRateFirst;
      case 'imageDefault':
        return EnumDBRPresetTemplate.imageDefault;
      default:
        throw Exception("Missing PresetTemplate for '$jsonValue'");
    }
  }

  String get jsonValue => _jsonValue();
  String _jsonValue() {
    switch (this) {
      case EnumDBRPresetTemplate.videoDefault:
        return 'default';
      case EnumDBRPresetTemplate.videoSingleBarcode:
        return 'videoSingleBarcode';
      case EnumDBRPresetTemplate.videoSpeedFirst:
        return 'videoSpeedFirst';
      case EnumDBRPresetTemplate.videoReadRateFirst:
        return 'videoReadRateFirst';
      case EnumDBRPresetTemplate.imageSpeedFirst:
        return 'imageSpeedFirst';
      case EnumDBRPresetTemplate.imageReadRateFirst:
        return 'imageReadRateFirst';
      case EnumDBRPresetTemplate.imageDefault:
        return 'imageDefault';  
      default:
        throw Exception("Missing Json Value for '$this' PresetTemplate");
    }
  }
}

