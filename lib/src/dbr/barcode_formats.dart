/// Supported barcode formats: https://www.dynamsoft.com/barcode-reader/parameters/enum/format-enums.html?ver=latest#barcodeformat
class EnumBarcodeFormat {
  /// All supported formats in BarcodeFormat group 1.
  static const int BF_ALL = -29360129;

  /// Combined value of BF_CODABAR, BF_CODE_128, BF_CODE_39, BF_CODE_39_Extended, BF_CODE_93, BF_EAN_13, BF_EAN_8, INDUSTRIAL_25, BF_ITF, BF_UPC_A, BF_UPC_E, BF_MSI_CODE
  static const int BF_ONED = 0x003007FF;

  /// Combined value of BF_GS1_DATABAR_OMNIDIRECTIONAL, BF_GS1_DATABAR_TRUNCATED, BF_GS1_DATABAR_STACKED, BF_GS1_DATABAR_STACKED_OMNIDIRECTIONAL, BF_GS1_DATABAR_EXPANDED, BF_GS1_DATABAR_EXPANDED_STACKED, BF_GS1_DATABAR_LIMITED
  static const int BF_GS1_DATABAR = 0x0003F800;

  /// Code 39
  static const int BF_CODE_39 = 0x1;

  /// Code 128
  static const int BF_CODE_128 = 0x2;

  /// Code 93
  static const int BF_CODE_93 = 0x4;

  /// Codabar
  static const int BF_CODABAR = 0x8;

  /// CODE_11 .
  static const int BF_CODE_11 = 0x200000;

  /// Interleaved 2 of 5
  static const int BF_ITF = 0x10;

  /// EAN-13
  static const int BF_EAN_13 = 0x20;

  /// EAN-8
  static const int BF_EAN_8 = 0x40;

  /// UPC-A
  static const int BF_UPC_A = 0x80;

  /// UPC-E
  static const int BF_UPC_E = 0x100;

  /// Industrial 2 of 5
  static const int BF_INDUSTRIAL_25 = 0x200;

  /// CODE39 Extended
  static const int BF_CODE_39_EXTENDED = 0x400;

  ///DataBar Omnidirectional
  static const int BF_GS1_DATABAR_OMNIDIRECTIONAL = 0x800;

  ///DataBar Truncated
  static const int BF_GS1_DATABAR_TRUNCATED = 0x1000;

  ///DataBar Stacked
  static const int BF_GS1_DATABAR_STACKED = 0x2000;

  ///DataBar Stacked Omnidirectional
  static const int BF_GS1_DATABAR_STACKED_OMNIDIRECTIONAL = 0x4000;

  ///DataBar Expanded
  static const int BF_GS1_DATABAR_EXPANDED = 0x8000;

  ///DataBar Expaned Stacked
  static const int BF_GS1_DATABAR_EXPANDED_STACKED = 0x10000;

  ///DataBar Limited
  static const int BF_GS1_DATABAR_LIMITED = 0x20000;

  /// Patch code.
  static const int BF_PATCHCODE = 0x00040000;

  /// PDF417
  static const int BF_PDF417 = 0x02000000;

  /// QRCode
  static const int BF_QR_CODE = 0x04000000;

  /// DataMatrix
  static const int BF_DATAMATRIX = 0x08000000;

  /// AZTEC
  static const int BF_AZTEC = 0x10000000;

  ///MAXICODE
  static const int BF_MAXICODE = 0x20000000;

  ///Micro QR Code
  static const int BF_MICRO_QR = 0x40000000;

  ///Micro PDF417
  static const int BF_MICRO_PDF417 = 0x00080000;

  ///GS1 Composite Code
  static const int BF_GS1_COMPOSITE = -2147483648;

  /// MSI Code
  static const int BF_MSI_CODE = 0x100000;

  /// No barcode format in BarcodeFormat group 1
  static const int BF_NULL = 0x00;
}

class EnumBarcodeFormat2 {
  /// No barcode format in BarcodeFormat group 2
  static const int BF2_NULL = 0x00;

  /// Nonstandard barcode
  static const int BF2_NONSTANDARD_BARCODE = 0x01;

  /// PHARMACODE_ONE_TRACK
  static const int BF2_PHARMACODE_ONE_TRACK = 0x04;

  /// PHARMACODE_ONE_TRACK
  static const int BF2_PHARMACODE_TWO_TRACK = 0x08;

  /// PHARMACODE
  static const int BF2_PHARMACODE = 0x0C;

  /// DotCode Barcode.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsMarks to EnumLocalizationMode if you don't set it.

  static const int BF2_DOTCODE = 0x00000002;

  /// Combined value of EnumBarcodeFormat2USPSINTELLIGENTMAIL,
  /// EnumBarcodeFormat2POSTNET, EnumBarcodeFormat2PLANET, EnumBarcodeFormat2AUSTRALIANPOST, EnumBarcodeFormat2RM4SCC.
  ///   When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int BF2_POSTALCODE = 0x01F00000;

  /// USPS Intelligent Mail.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int BF2_USPSINTELLIGENTMAIL = 0x00100000;

  /// Postnet.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int BF2_POSTNET = 0x00200000;

  /// Planet.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int BF2_PLANET = 0x00400000;

  /// Australian Post.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int BF2_AUSTRALIANPOST = 0x00800000;

  /// Royal Mail 4-State Customer Barcode.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int BF2_RM4SCC = 0x01000000;
}
