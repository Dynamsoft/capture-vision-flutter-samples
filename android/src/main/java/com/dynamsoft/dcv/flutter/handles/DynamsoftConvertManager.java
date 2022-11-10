package com.dynamsoft.dcv.flutter.handles;

import android.util.Base64;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dynamsoft.dbr.BarcodeReaderException;
import com.dynamsoft.dbr.EnumPresetTemplate;
import com.dynamsoft.dbr.FurtherModes;
import com.dynamsoft.dbr.Point;
import com.dynamsoft.dbr.PublicRuntimeSettings;
import com.dynamsoft.dce.RegionDefinition;
import com.dynamsoft.dbr.TextResult;

public class DynamsoftConvertManager {

	private volatile static DynamsoftConvertManager manager;

	private DynamsoftConvertManager() {
	}

	public static DynamsoftConvertManager manager() {
		if (manager == null) {
			synchronized (DynamsoftConvertManager.class) {
				if (manager == null) {
					manager = new DynamsoftConvertManager();
				}
			}
		}
		return manager;
	}

	/**
	 * Convert json to PublicRuntimeSettings
	 */
	public PublicRuntimeSettings aynlyzeRuntimeSettingsFromJson(Object arguments) throws BarcodeReaderException {
		Map settings = (Map) ((Map) arguments).get("runtimeSettings");

		PublicRuntimeSettings publicRuntimeSettings = DynamsoftSDKManager.manager().barcodeReader.getRuntimeSettings();
		if (settings.get("barcodeFormatIds") != null) {
			publicRuntimeSettings.barcodeFormatIds = (int) settings.get("barcodeFormatIds");
		}
		if (settings.get("barcodeFormatIds_2") != null) {
			publicRuntimeSettings.barcodeFormatIds_2 = (int) settings.get("barcodeFormatIds_2");
		}
		if (settings.get("expectedBarcodeCount") != null) {
			publicRuntimeSettings.expectedBarcodesCount = (int) settings.get("expectedBarcodeCount");
		}
		if (settings.get("timeout") != null) {
			publicRuntimeSettings.timeout = (int) settings.get("timeout");
		}
		if (settings.get("minResultConfidence") != null) {
			publicRuntimeSettings.minResultConfidence = (int) settings.get("minResultConfidence");
		}
		if (settings.get("minBarcodeTextLength") != null) {
			publicRuntimeSettings.minBarcodeTextLength = (int) settings.get("minBarcodeTextLength");
		}
		if (settings.get("binarizationModes") != null) {
			publicRuntimeSettings.binarizationModes = intListToArray(((List<Integer>)settings.get("binarizationModes")));
		}
		if (settings.get("deblurLevel") != null) {
			publicRuntimeSettings.deblurLevel = (int) settings.get("deblurLevel");
		}
		if (settings.get("deblurModes") != null) {
			publicRuntimeSettings.deblurModes = intListToArray((List<Integer>) settings.get("deblurModes"));
		}
		if (settings.get("localizationModes") != null) {
			publicRuntimeSettings.localizationModes = intListToArray((List<Integer>) settings.get("localizationModes"));
		}
		if (settings.get("region") != null) {
			com.dynamsoft.dbr.RegionDefinition regionDefinition = new com.dynamsoft.dbr.RegionDefinition();
			HashMap<String, Integer> region = (HashMap<String, Integer>) settings.get("region");
			if (region != null) {
				regionDefinition.regionTop = region.get("regionTop");
				regionDefinition.regionBottom = region.get("regionBottom");
				regionDefinition.regionLeft = region.get("regionLeft");
				regionDefinition.regionRight = region.get("regionRight");
				regionDefinition.regionMeasuredByPercentage = region.get("regionMeasuredByPercentage");
			}
			publicRuntimeSettings.region = regionDefinition;
		}
		if (settings.get("scaleDownThreshold") != null) {
			publicRuntimeSettings.scaleDownThreshold = (int) settings.get("scaleDownThreshold");
		}
		if (settings.get("scaleUpModes") != null) {
			publicRuntimeSettings.scaleUpModes = intListToArray((List<Integer>) settings.get("scaleUpModes"));
		}
		if (settings.get("textResultOrderModes") != null) {
			publicRuntimeSettings.textResultOrderModes = intListToArray((List<Integer>) settings.get("textResultOrderModes"));
		}
		if (settings.get("furtherModes") != null) {
			FurtherModes modes = new FurtherModes();
			HashMap<String, Object> map = (HashMap<String, Object>) settings.get("furtherModes");
			if (map != null) {
				modes.colourClusteringModes = intListToArray((List<Integer>) map.get("colourClusteringModes"));
				modes.colourConversionModes = intListToArray((List<Integer>) map.get("colourConversionModes"));
				modes.grayscaleTransformationModes = intListToArray((List<Integer>) map.get("grayscaleTransformationModes"));
				modes.regionPredetectionModes = intListToArray((List<Integer>) map.get("regionPredetectionModes"));
				modes.imagePreprocessingModes = intListToArray((List<Integer>) map.get("imagePreprocessingModes"));
				modes.textureDetectionModes = intListToArray((List<Integer>) map.get("textureDetectionModes"));
				modes.textFilterModes = intListToArray((List<Integer>) map.get("textFilterModes"));
				modes.dpmCodeReadingModes = intListToArray((List<Integer>) map.get("dpmCodeReadingModes"));
				modes.deformationResistingModes = intListToArray((List<Integer>) map.get("deformationResistingModes"));
				modes.barcodeComplementModes = intListToArray((List<Integer>) map.get("barcodeComplementModes"));
				modes.barcodeColourModes = intListToArray((List<Integer>) map.get("barcodeColourModes"));
				publicRuntimeSettings.furtherModes = modes;
			}
		}
		return publicRuntimeSettings;
	}

	/**
	 * Convert json to EnumPresetTemplate
	 */
	public EnumPresetTemplate aynlyzePresetTemplateFromJson(Object arguments) {
		String presetTemplate = (String) ((Map) arguments).get("presetTemplate");
		EnumPresetTemplate enumPresetTemplate = EnumPresetTemplate.DEFAULT;
		switch (presetTemplate) {
			case "defaultTemplate":
				enumPresetTemplate = EnumPresetTemplate.DEFAULT;
				break;
			case "videoSingleBarcode":
				enumPresetTemplate = EnumPresetTemplate.VIDEO_SINGLE_BARCODE;
				break;
			case "videoSpeedFirst":
				enumPresetTemplate = EnumPresetTemplate.VIDEO_SPEED_FIRST;
				break;
			case "videoReadRateFirst":
				enumPresetTemplate = EnumPresetTemplate.VIDEO_READ_RATE_FIRST;
				break;
			case "imageSpeedFirst":
				enumPresetTemplate = EnumPresetTemplate.IMAGE_SPEED_FIRST;
				break;
			case "imageReadRateFirst":
				enumPresetTemplate = EnumPresetTemplate.IMAGE_READ_RATE_FIRST;
				break;
			case "imageDefault":
				enumPresetTemplate = EnumPresetTemplate.IMAGE_DEFAULT;
				break;
			default:
				break;
		}
		return enumPresetTemplate;
	}


	/**
	 * Convert json to RegionDefinition
	 */
	public RegionDefinition aynlyzeiRegionDefinitionFromJson(Object arguments) {
		Map scanRegion = (Map) ((Map) arguments).get("scanRegion");
		int regionTop = (int) scanRegion.get("regionTop");
		int regionBottom = (int) scanRegion.get("regionBottom");
		int regionLeft = (int) scanRegion.get("regionLeft");
		int regionRight = (int) scanRegion.get("regionRight");
		int regionMeasuredByPercentage = (int) scanRegion.get("regionMeasuredByPercentage");
		RegionDefinition regionDefinition = new RegionDefinition();
		regionDefinition.regionTop = regionTop;
		regionDefinition.regionBottom = regionBottom;
		regionDefinition.regionLeft = regionLeft;
		regionDefinition.regionRight = regionRight;

		regionDefinition.regionMeasuredByPercentage = regionMeasuredByPercentage;
		return regionDefinition;
	}

	/**
	 * Wrap textResults to Json
	 */
	public List wrapResultsToJson(TextResult[] textResults) {

		List jsonList = new ArrayList();

		for (int i = 0; i < textResults.length; i++) {
			TextResult textResult = textResults[i];
			final String barcodeBytesString = Base64.encodeToString(textResult.barcodeBytes, Base64.NO_WRAP);
			final String barcodeFormatString;
			if (textResult.barcodeFormat_2 != 0) {
				barcodeFormatString = textResult.barcodeFormatString_2;
			} else {
				barcodeFormatString = textResult.barcodeFormatString;
			}

			List locationPoints = new ArrayList();
			for (int j = 0; j < textResult.localizationResult.resultPoints.length; j++) {
				Point point = textResult.localizationResult.resultPoints[j];
				locationPoints.add(new HashMap<String, Object>() {
					{
						put("x", point.x);
						put("y", point.y);
					}
				});
			}


			jsonList.add(new HashMap<String, Object>() {
				{
					put("barcodeText", textResult.barcodeText);
					put("barcodeFormatString", barcodeFormatString);
					put("barcodeBytesString", barcodeBytesString);
					put("barcodeLocation", new HashMap<String, Object>() {
						{
							put("angle", textResult.localizationResult.angle);
							put("location", new HashMap<String, Object>() {
								{
									put("pointsList", locationPoints);
								}
							});
						}
					});
				}
			});
		}
		return jsonList;
	}

	/**
	 * Wrap PublicRuntimeSettings to Json
	 */
	public HashMap<String, Object> wrapRuntimeSettingsToJson(PublicRuntimeSettings runtimeSettings) {
		HashMap<String, Integer> regionMap = new HashMap<String, Integer>();
		HashMap<String, Object> furtherModesMap = new HashMap<String, Object>();

		if (runtimeSettings.region != null) {
			regionMap.put("regionTop", runtimeSettings.region.regionTop);
			regionMap.put("regionBottom", runtimeSettings.region.regionBottom);
			regionMap.put("regionLeft", runtimeSettings.region.regionLeft);
			regionMap.put("regionRight", runtimeSettings.region.regionRight);
			regionMap.put("regionMeasuredByPercentage", runtimeSettings.region.regionMeasuredByPercentage);
		}

		if (runtimeSettings.furtherModes != null) {
			furtherModesMap.put("textAssistedCorrectionMode", runtimeSettings.furtherModes.textAssistedCorrectionMode);
			furtherModesMap.put("colourClusteringModes", runtimeSettings.furtherModes.colourClusteringModes);
			furtherModesMap.put("colourConversionModes", runtimeSettings.furtherModes.colourConversionModes);
			furtherModesMap.put("grayscaleTransformationModes", runtimeSettings.furtherModes.grayscaleTransformationModes);
			furtherModesMap.put("regionPredetectionModes", runtimeSettings.furtherModes.regionPredetectionModes);
			furtherModesMap.put("imagePreprocessingModes", runtimeSettings.furtherModes.imagePreprocessingModes);
			furtherModesMap.put("textureDetectionModes", runtimeSettings.furtherModes.textureDetectionModes);
			furtherModesMap.put("textFilterModes", runtimeSettings.furtherModes.textFilterModes);
			furtherModesMap.put("dpmCodeReadingModes", runtimeSettings.furtherModes.dpmCodeReadingModes);
			furtherModesMap.put("deformationResistingModes", runtimeSettings.furtherModes.deformationResistingModes);
			furtherModesMap.put("barcodeComplementModes", runtimeSettings.furtherModes.barcodeComplementModes);
			furtherModesMap.put("barcodeColourModes", runtimeSettings.furtherModes.barcodeColourModes);
			furtherModesMap.put("accompanyingTextRecognitionModes", runtimeSettings.furtherModes.accompanyingTextRecognitionModes);
		}


		return new HashMap<String, Object>() {
			{
				put("barcodeFormatIds", runtimeSettings.barcodeFormatIds);
				put("barcodeFormatIds_2", runtimeSettings.barcodeFormatIds_2);
				put("expectedBarcodeCount", runtimeSettings.expectedBarcodesCount);
				put("timeout", runtimeSettings.timeout);
				put("binarizationModes", runtimeSettings.binarizationModes);
				put("deblurLevel", runtimeSettings.deblurLevel);
				put("deblurModes", runtimeSettings.deblurModes);
				put("localizationModes", runtimeSettings.localizationModes);
				put("region", regionMap);
				put("scaleDownThreshold", runtimeSettings.scaleDownThreshold);
				put("scaleUpModes", runtimeSettings.scaleUpModes);
				put("textResultOrderModes", runtimeSettings.textResultOrderModes);
				put("binarizationModes", runtimeSettings.binarizationModes);
				put("minBarcodeTextLength", runtimeSettings.minBarcodeTextLength);
				put("minResultConfidence", runtimeSettings.minResultConfidence);
				put("furtherModes", furtherModesMap);
			}
		};
	}


	private int[] intListToArray(List<Integer> intList) {
		if(intList!=null && intList.size()>0) {
			int[] array = new int[intList.size()];
			for(int i=0; i<array.length; i++) {
				array[i] = intList.get(i);
			}
			return array;
		}
		return null;
	}

}