/// Supported barcode formats: https://www.dynamsoft.com/barcode-reader/parameters/enum/format-enums.html?ver=latest#barcodeformat
class EnumBarcodeFormat {
  /// All supported formats in BarcodeFormat group 1.
  static const int all = -29360129;

  /// Combined value of BF_CODABAR, BF_CODE_128, BF_CODE_39, BF_CODE_39_Extended, BF_CODE_93, BF_EAN_13, BF_EAN_8, INDUSTRIAL_25, BF_ITF, BF_UPC_A, BF_UPC_E, BF_MSI_CODE
  static const int oneD = 0x003007FF;

  /// Combined value of BF_GS1_DATABAR_OMNIDIRECTIONAL, BF_GS1_DATABAR_TRUNCATED, BF_GS1_DATABAR_STACKED, BF_GS1_DATABAR_STACKED_OMNIDIRECTIONAL, BF_GS1_DATABAR_EXPANDED, BF_GS1_DATABAR_EXPANDED_STACKED, BF_GS1_DATABAR_LIMITED
  static const int gs1DataBar = 0x0003F800;

  /// Code 39
  static const int code39 = 0x1;

  /// Code 128
  static const int code128 = 0x2;

  /// Code 93
  static const int code93 = 0x4;

  /// Codabar
  static const int codeBar = 0x8;

  /// CODE_11 .
  static const int code11 = 0x200000;

  /// Interleaved 2 of 5
  static const int itf = 0x10;

  /// EAN-13
  static const int ean13 = 0x20;

  /// EAN-8
  static const int ean8 = 0x40;

  /// UPC-A
  static const int upca = 0x80;

  /// UPC-E
  static const int upce = 0x100;

  /// Industrial 2 of 5
  static const int industrial25 = 0x200;

  /// CODE39 Extended
  static const int code39Extended = 0x400;

  ///DataBar Omnidirectional
  static const int gs1DatabarOmnidirectional = 0x800;

  ///DataBar Truncated
  static const int gs1DatabarTruncated = 0x1000;

  ///DataBar Stacked
  static const int gs1DatabarStacked = 0x2000;

  ///DataBar Stacked Omnidirectional
  static const int gs1DatabarStackedDOmnidirectional = 0x4000;

  ///DataBar Expanded
  static const int gs1DatabarExpanded = 0x8000;

  ///DataBar Expaned Stacked
  static const int gs1DatabarExpandedStacked = 0x10000;

  ///DataBar Limited
  static const int gs1DatabarLimited = 0x20000;

  /// Patch code.
  static const int patchCode = 0x00040000;

  /// PDF417
  static const int pdf417 = 0x02000000;

  /// QRCode
  static const int qrCode = 0x04000000;

  /// DataMatrix
  static const int dataMatrix = 0x08000000;

  /// AZTEC
  static const int aztec = 0x10000000;

  ///MAXICODE
  static const int maxiCode = 0x20000000;

  ///Micro QR Code
  static const int microQR = 0x40000000;

  ///Micro PDF417
  static const int microPDF417 = 0x00080000;

  ///GS1 Composite Code
  static const int gs1Composite = -2147483648;

  /// MSI Code
  static const int msiCode = 0x100000;

  /// No barcode format in BarcodeFormat group 1
  static const int none = 0x00;
}

class EnumBarcodeFormat2 {
  /// No barcode format in BarcodeFormat group 2
  static const int none = 0x00;

  /// Nonstandard barcode
  static const int nonStandardBarcode = 0x01;

  /// PHARMACODE_ONE_TRACK
  static const int pharmaCodeOneTrack = 0x04;

  /// PHARMACODE_TWO_TRACK
  static const int pharmaCodeTwoTrack = 0x08;

  /// PHARMACODE
  static const int pharmaCode = 0x0C;

  /// DotCode Barcode.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsMarks to EnumLocalizationMode if you don't set it.

  static const int dotCode = 0x00000002;

  /// Combined value of EnumBarcodeFormat2USPSINTELLIGENTMAIL,
  /// EnumBarcodeFormat2POSTNET, EnumBarcodeFormat2PLANET, EnumBarcodeFormat2AUSTRALIANPOST, EnumBarcodeFormat2RM4SCC.
  ///   When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int postalCode = 0x01F00000;

  /// USPS Intelligent Mail.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int uspsIntelligentMail = 0x00100000;

  /// Postnet.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int postNet = 0x00200000;

  /// Planet.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int planet = 0x00400000;

  /// Australian Post.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int australianPost = 0x00800000;

  /// Royal Mail 4-State Customer Barcode.
  ///When you set this barcode format, the library will automatically add EnumLocalizationModeStatisticsPostalCode to EnumLocalizationMode if you don't set it.

  static const int rm4Scc = 0x01000000;
}
