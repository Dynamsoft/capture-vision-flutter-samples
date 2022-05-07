package com.dynamsoft.dynamsoft_capture_vision_flutter.src;

import android.content.Context;
import android.util.Log;
import androidx.annotation.NonNull;
import java.util.Map;
import java.util.function.Function;

/// Plugin
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.StreamHandler;

/// SDK
import com.dynamsoft.dbr.BarcodeReaderException;
import com.dynamsoft.dbr.EnumConflictMode;
import com.dynamsoft.dbr.EnumPresetTemplate;
import com.dynamsoft.dbr.PublicRuntimeSettings;
import com.dynamsoft.dbr.TextResult;
import com.dynamsoft.dce.DCEFrame;
import com.dynamsoft.dce.RegionDefinition;
import com.dynamsoft.dce.CameraEnhancerException;

/// View
import com.dynamsoft.dynamsoft_capture_vision_flutter.src.capture_view.BarcodeScanningCaptureView;

/// Handles
import com.dynamsoft.dynamsoft_capture_vision_flutter.src.handles.DynamsoftConvertManager;
import com.dynamsoft.dynamsoft_capture_vision_flutter.src.handles.DynamsoftSDKManager;
import com.dynamsoft.dynamsoft_capture_vision_flutter.src.handles.DynamsoftToolsManager;

public class DynamsoftCaptureVisionFactory extends PlatformViewFactory implements MethodCallHandler, StreamHandler{

    /** MethodChannel */
    private MethodChannel methodChannel;

    /** BarcodeResultEventChannel */
    private EventChannel barcodeResultEventChannel;

    private Result resultMethod;

    private EventChannel.EventSink textResultStream;

    private BarcodeScanningCaptureView captureView;

    public DynamsoftCaptureVisionFactory(MessageCodec<Object> createArgsCodec, FlutterPlugin.FlutterPluginBinding flutterPluginBinding ) {
        super(createArgsCodec);

        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), Common.methodChannel_Identifier);
        methodChannel.setMethodCallHandler(this);

        barcodeResultEventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), Common.barcodeResult_EventChannel_Identifier);
        barcodeResultEventChannel.setStreamHandler(this);
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {

        captureView = new BarcodeScanningCaptureView(DynamsoftToolsManager.manager().getActivity());
        return captureView;

    }

    /** Please invoke this method when plugin is detached. */
    public void dipose() {
        methodChannel.setMethodCallHandler(null);
    }

    /** EventChannel */
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {

        String streamName = ((Map)arguments).get("streamName").toString();
        if (streamName.equals(Common.barcodeReader_addResultlistener)) {
            textResultStream = events;
            DynamsoftSDKManager.manager().textResultCallBack(textResultStream);
        }

    }

    @Override
    public void onCancel(Object arguments) {

    }

    /** MethodChannel */
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        resultMethod = result;
        switch(call.method) {
            /// DBR
            case Common.barcodeReader_initLicense:
                barcodeReaderInitLicense(call.arguments);
                break;
            case Common.barcodeReader_createInstance:
                barcodeReaderCreateInstance(call.arguments);
                break;
            case Common.barcodeReader_getVersion:
                barcodeReaderGetVersion(call.arguments);
                break;
            case Common.barcodeReader_startScanning:
                barcodeReaderStartScanning(call.arguments);
                break;
            case Common.barcodeReader_stopScanning:
                barcodeReaderStopScanning(call.arguments);
                break;
            case Common.barcodeReader_updateRuntimeSettings:
                barcodeReaderUpdateRuntimeSettings(call.arguments);
                break;
            case Common.barcodeReader_getRuntimeSettings:
                barcodeReaderGetRuntimeSettings(call.arguments);
                break;
            case Common.barcodeReader_updateRuntimeSettingsFromTemplate:
                barcodeReaderUpdateRuntimeSettingsFromTemplate(call.arguments);
                break;
            case Common.barcodeReader_updateRuntimeSettingsFromJson:
                barcodeReaderUpdateRuntimeSettingsFromJson(call.arguments);
                break;
            case Common.barcodeReader_resetRuntimeSettings:
                barcodeReaderResetRuntimeSettings(call.arguments);
                break;
            case Common.barcodeReader_outputRuntimeSettingsToString:
                barcodeReaderOutputRuntimeSettingsToString(call.arguments);
                break;


            /// DCE
            case Common.cameraEnhancer_dispose:
                cameraEnhancerDispose(call.arguments);
                break;
            case Common.cameraEnhancer_setScanRegion:
                cameraEnhancerSetScanRegion(call.arguments);
                break;
            case Common.cameraEnhancer_setScanRegionVisible:
                cameraEnhancerSetScanRegionVisible(call.arguments);
                break;
            case Common.cameraEnhancer_setOverlayVisible:
                cameraEnhancerSetOverlayVisible(call.arguments);
                break;

            /// Navigation and lifecycle methods
            case Common.navigation_didPushNext:
                navigationDidPushNext();
                break;
            case Common.navigation_didPopNext:
                navigationDidPopNext();
                break;
            case Common.appState_becomeResumed:
                appStateBecomeResumed();
                break;
            case Common.appState_becomeInactive:
                appStateBecomeInactive();
                break;

            default:
                result.notImplemented();
        }

    }


    /// DBR methods
    private void barcodeReaderInitLicense(Object arguments) {
        DynamsoftSDKManager.manager().barcodeReaderInitLicense(arguments, resultMethod);
    }

    private void barcodeReaderCreateInstance(Object arguments) {
        DynamsoftSDKManager.manager().barcodeReaderCreateInstance(arguments, resultMethod);
    }

    private void barcodeReaderGetVersion(Object arguments) {
        resultMethod.success(DynamsoftSDKManager.manager().barcodeReader.getVersion());
    }

    private void barcodeReaderStartScanning(Object arguments) {

        if (DynamsoftSDKManager.manager().cameraEnhancer != null && DynamsoftSDKManager.manager().barcodeReaderLinkCameraEnhancerIsFinished == false) {
            DynamsoftSDKManager.manager().barcodeReaderLinkCameraEnhancerIsFinished = true;
            DynamsoftSDKManager.manager().barcodeReader.setCameraEnhancer(DynamsoftSDKManager.manager().cameraEnhancer);
        }
        DynamsoftSDKManager.manager().barcodeReader.startScanning();

        resultMethod.success(null);
    }

    private void barcodeReaderStopScanning(Object arguments) {
        DynamsoftSDKManager.manager().barcodeReader.stopScanning();
        resultMethod.success(null);
    }

    private void barcodeReaderUpdateRuntimeSettings(Object arguments) {

        try {
            PublicRuntimeSettings runtimeSettings = DynamsoftConvertManager.manager().aynlyzeRuntimeSettingsFromJson(arguments);
            DynamsoftSDKManager.manager().barcodeReader.updateRuntimeSettings(runtimeSettings);
            resultMethod.success(null);
        } catch (BarcodeReaderException e) {

            resultMethod.error(Common.exceptionTip, e.getMessage(), null);
        }
    }

    private void barcodeReaderGetRuntimeSettings(Object arguments) {
        try {
            PublicRuntimeSettings runtimeSettings = DynamsoftSDKManager.manager().barcodeReader.getRuntimeSettings();
            resultMethod.success(DynamsoftConvertManager.manager().wrapRuntimeSettingsToJson(runtimeSettings));
        } catch (BarcodeReaderException e) {
            resultMethod.error(Common.exceptionTip, e.getMessage(), null);
        }

    }

    private void barcodeReaderUpdateRuntimeSettingsFromTemplate(Object arguments) {
        EnumPresetTemplate presetTemplate = DynamsoftConvertManager.manager().aynlyzePresetTemplateFromJson(arguments);
        DynamsoftSDKManager.manager().barcodeReader.updateRuntimeSettings(presetTemplate);

        resultMethod.success(null);
    }

    private void barcodeReaderUpdateRuntimeSettingsFromJson(Object arguments) {
        String jsonString = (String)((Map)arguments).get("jsonString");
        try {
            DynamsoftSDKManager.manager().barcodeReader.initRuntimeSettingsWithString(jsonString
                    , EnumConflictMode.CM_OVERWRITE);
            resultMethod.success(null);
        } catch (BarcodeReaderException e) {
            resultMethod.error(Common.exceptionTip, e.getMessage(), null);
        }
    }

    private void barcodeReaderResetRuntimeSettings(Object arguments) {
        try {
            DynamsoftSDKManager.manager().barcodeReader.resetRuntimeSettings();
            resultMethod.success(null);
        } catch (BarcodeReaderException e) {
            resultMethod.error(Common.exceptionTip, e.getMessage(), null);
        }
    }

    private void barcodeReaderOutputRuntimeSettingsToString(Object arguments) {

        try {
            String settingsString = DynamsoftSDKManager.manager().barcodeReader.outputSettingsToString("");
            resultMethod.success(settingsString);
        } catch (BarcodeReaderException e) {
            resultMethod.error(Common.exceptionTip, e.getMessage(), null);
        }
    }

    /// DCE methods

    private void cameraEnhancerDispose(Object arguments) {
        DynamsoftSDKManager.manager().barcodeReaderLinkCameraEnhancerIsFinished = false;
        if (DynamsoftSDKManager.manager().barcodeReader != null) {
            DynamsoftSDKManager.manager().barcodeReader.stopScanning();
        }

        try {
            DynamsoftSDKManager.manager().cameraEnhancer.close();
        } catch (CameraEnhancerException e) {
            e.printStackTrace();
        }
        DynamsoftSDKManager.manager().cameraEnhancer = null;

        resultMethod.success(null);
    }

    private void cameraEnhancerSetScanRegion(Object arguments) {
        RegionDefinition regionDefinition = ((Map)arguments).get("scanRegion") == null ? null : DynamsoftConvertManager.manager().aynlyzeiRegionDefinitionFromJson(arguments);

        try {
            DynamsoftSDKManager.manager().cameraEnhancer.setScanRegion(regionDefinition);
            resultMethod.success(null);
        } catch (CameraEnhancerException e) {
            resultMethod.error(Common.exceptionTip, e.getMessage(), null);
        }
    }

    private void cameraEnhancerSetScanRegionVisible(Object arguments) {

        boolean scanRegionVisible = (boolean)((Map)arguments).get("isVisible");
        DynamsoftSDKManager.manager().cameraEnhancer.setScanRegionVisible(scanRegionVisible);
        resultMethod.success(null);
    }

    private void cameraEnhancerSetOverlayVisible(Object arguments) {
        boolean overlayVisible = (boolean)((Map)arguments).get("isVisible");
        captureView.cameraView.setOverlayVisible(overlayVisible);
        resultMethod.success(null);
    }

    /// Navigation and lifecycle methods
    private void navigationDidPopNext() {
        if (DynamsoftSDKManager.manager().cameraEnhancer != null && DynamsoftSDKManager.manager().barcodeReaderLinkCameraEnhancerIsFinished == true) {
            try {
                DynamsoftSDKManager.manager().cameraEnhancer.open();
            } catch (CameraEnhancerException e) {
                e.printStackTrace();
            }
        }
    }

    private void navigationDidPushNext() {
        if (DynamsoftSDKManager.manager().cameraEnhancer != null && DynamsoftSDKManager.manager().barcodeReaderLinkCameraEnhancerIsFinished == true) {
            try {
                DynamsoftSDKManager.manager().cameraEnhancer.close();
            } catch (CameraEnhancerException e) {
                e.printStackTrace();
            }
        }
    }

    private void appStateBecomeResumed() {
        if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
            try {
                DynamsoftSDKManager.manager().cameraEnhancer.open();
            } catch (CameraEnhancerException e) {
                e.printStackTrace();
            }
        }

    }

    private void appStateBecomeInactive() {
        if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
            try {
                DynamsoftSDKManager.manager().cameraEnhancer.close();
            } catch (CameraEnhancerException e) {
                e.printStackTrace();
            }
        }
    }

}
