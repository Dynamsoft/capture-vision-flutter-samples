package com.dynamsoft.dcv.flutter.handles;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dynamsoft.dbr.BarcodeReaderException;
import com.dynamsoft.dbr.EnumPresetTemplate;
import com.dynamsoft.dbr.Point;
import com.dynamsoft.dbr.PublicRuntimeSettings;
import com.dynamsoft.dce.RegionDefinition;
import com.dynamsoft.dbr.TextResult;

public class DynamsoftConvertManager {

    private volatile  static DynamsoftConvertManager manager;
    private DynamsoftConvertManager() {}

    public  static DynamsoftConvertManager manager() {
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
        Map settings = (Map)((Map)arguments).get("runtimeSettings");

        PublicRuntimeSettings publicRuntimeSettings = DynamsoftSDKManager.manager().barcodeReader.getRuntimeSettings();
        publicRuntimeSettings.barcodeFormatIds = (int)settings.get("barcodeFormatIds");
        publicRuntimeSettings.barcodeFormatIds_2 = (int)settings.get("barcodeFormatIds_2");
        publicRuntimeSettings.expectedBarcodesCount = (int)settings.get("expectedBarcodeCount");
        publicRuntimeSettings.timeout = (int)settings.get("timeout");
        return publicRuntimeSettings;
    }

    /**
     * Convert json to EnumPresetTemplate
     */
    public EnumPresetTemplate aynlyzePresetTemplateFromJson(Object arguments) {
        String presetTemplate = (String)((Map)arguments).get("presetTemplate");
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
        Map scanRegion = (Map) ((Map)arguments).get("scanRegion");
        int regionTop = (int)scanRegion.get("regionTop");
        int regionBottom = (int)scanRegion.get("regionBottom");
        int regionLeft = (int)scanRegion.get("regionLeft");
        int regionRight = (int)scanRegion.get("regionRight");
        Boolean regionMeasuredByPercentage = (Boolean)scanRegion.get("regionMeasuredByPercentage");
        RegionDefinition regionDefinition = new RegionDefinition();
        regionDefinition.regionTop = regionTop;
        regionDefinition.regionBottom = regionBottom;
        regionDefinition.regionLeft = regionLeft;
        regionDefinition.regionRight = regionRight;

        regionDefinition.regionMeasuredByPercentage = regionMeasuredByPercentage == true ? 1 : 0;
        return regionDefinition;
    }

    /**
     * Wrap textResults to Json
     */
    public List wrapResultsToJson(TextResult[] textResults) {

        List jsonList = new ArrayList();
        for (int i = 0; i < textResults.length; i++) {
            TextResult textResult = textResults[i];
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


            jsonList.add(new HashMap<String, Object>(){
                {
                    put("barcodeText", textResult.barcodeText);
                    put("barcodeFormatString", barcodeFormatString);
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
     *  Wrap PublicRuntimeSettings to Json
     */
    public Map wrapRuntimeSettingsToJson(PublicRuntimeSettings runtimeSettings) {

        return new HashMap<String, Object>() {
            {
                put("barcodeFormatIds", runtimeSettings.barcodeFormatIds);
                put("barcodeFormatIds_2", runtimeSettings.barcodeFormatIds_2);
                put("expectedBarcodeCount", runtimeSettings.expectedBarcodesCount);
                put("timeout", runtimeSettings.timeout);
            }
        };
    }


}