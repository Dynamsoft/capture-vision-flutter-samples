## 1.2.2

### Fixed

* Fixed a crash bug on the devices that do not support 16:9 size resolution.
* Fixed a display bug when the display orientation is landscape.

## 1.2.1

### Improved

* Optimized the internal code to support more usage scenarios.

## 1.2.0

### New

* Extended `DBRRuntimeSettings` with more **mode parameters**. You can further optimize the barcode decoding performance of your project with the **mode parameters**:
  * `binarizationModes`
  * `deblurLevel`
  * `deblurModes`
  * `region`
  * `scaleDownThreshold`
  * `scaleUpModes`
  * `textResultOrderModes`
  * `furtherModes`
* Added a new class `FurtherModes` to set the `furtherModes` parameter of `DBRRuntimeSettings`.
* Added new methods `setModeArgument` and `getModeArgument` in class `DCVBarcodeReader`. These two methods give you access to the optional arguments of the **mode parameters**.
* Added enumeration classes to set **mode parameters**.

## 1.1.1

### Fixed

* Fixed a bug that could result in incorrect counts for scanned barcodes.

## 1.1.0

### New

* Added a new method `decodeFile` in Barcode Reader module to decode barcodes from an image file.
* Added a new method `enableResultVerification` in Barcode Reader module to further improve the accuracy of barcode result.
* Added a new property `torchButton` to `DCVCameraView` class for users to create a torch button on the view.
* Added a new class `Rect`.
* Added a new property `barcodeBytes` in `BarcodeResult` to output the byte data of the barcode.
* Added a new property `minResultConfidence` in `DBRRuntimeSettings` to filter the barcode results by confidence.
* Added a new property `minResultTextLength` in `DBRRuntimeSettings` to filter the barcode results by text length.
* Added `DCVCameraEnhancer` class. Moved camera control APIs from `DCVCameraView` class to `DCVCameraEnhancer` class. Added a new method `selectCamera` in `DCVCameraEnhancer` class for users to switch between front-facing camera and back-facing camera.
* Added an enumeration `EnumCameraPosition`.

### Changes

* Renamed `DynamsoftBarcodeReader` class to `DCVBarcodeReader`.
* Renamed `DynamsoftCameraView` class to `DCVCameraView`.
* Users have to call `DCVCameraEnhancer.open`/`DCVCameraEnhancer.close` manually when the application is **resumed**/**inactive**.

## 1.0.1

* Fixed a bug.

## 1.0.0

* Dynamsoft Capture Vision is an aggregating SDK of a series of specific functional products. In 1.0 version, The following products are included:
  * Dynamsoft Camera Enhancer: Provides camera enhancements and UI configuration APIs.
  * Dynamsoft Barcode Reader: Provides barcode decoding algorithm and APIs.

