package com.dynamsoft.dcv.flutter;

import android.app.Activity;
import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Point;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.pdf.PdfDocument;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

/// Plugin
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.JSONMessageCodec;
import io.flutter.plugin.common.JSONUtil;
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
import com.dynamsoft.dbr.BarcodeReader;
import com.dynamsoft.dbr.BarcodeReaderException;
import com.dynamsoft.dbr.EnumConflictMode;
import com.dynamsoft.dbr.EnumPresetTemplate;
import com.dynamsoft.dbr.PublicRuntimeSettings;
import com.dynamsoft.dbr.TextResult;
import com.dynamsoft.dce.CameraEnhancer;
import com.dynamsoft.dce.DCEFrame;
import com.dynamsoft.dce.EnumCameraPosition;
import com.dynamsoft.dce.RegionDefinition;
import com.dynamsoft.dce.CameraEnhancerException;

/// View
import com.dynamsoft.dcv.flutter.capture_view.BarcodeScanningCaptureView;

/// Handles
import com.dynamsoft.dcv.flutter.handles.DynamsoftConvertManager;
import com.dynamsoft.dcv.flutter.handles.DynamsoftSDKManager;
import com.dynamsoft.dcv.flutter.handles.DynamsoftToolsManager;

public class DynamsoftCaptureVisionFactory extends PlatformViewFactory implements MethodCallHandler, StreamHandler {

	/**
	 * MethodChannel
	 */
	private MethodChannel methodChannel;

	/**
	 * BarcodeResultEventChannel
	 */
	private EventChannel barcodeResultEventChannel;

	private EventChannel.EventSink textResultStream;

	private BarcodeScanningCaptureView captureView;

	private Context mContext;

	private FlutterPlugin.FlutterAssets flutterAssets;

	private AssetManager assetManager;

	public DynamsoftCaptureVisionFactory(MessageCodec<Object> createArgsCodec, FlutterPlugin.FlutterPluginBinding flutterPluginBinding) {
		super(createArgsCodec);

		flutterAssets = flutterPluginBinding.getFlutterAssets();
		mContext = flutterPluginBinding.getApplicationContext();
		assetManager = flutterPluginBinding.getApplicationContext().getAssets();

		methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), Common.methodChannel_Identifier);
		methodChannel.setMethodCallHandler(this);

		barcodeResultEventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), Common.barcodeResult_EventChannel_Identifier);
		barcodeResultEventChannel.setStreamHandler(this);
	}

	@Override
	public PlatformView create(Context context, int viewId, Object args) {
		captureView = new BarcodeScanningCaptureView(context);
		return captureView;

	}

	/**
	 * Please invoke this method when plugin is detached.
	 */
	public void dipose() {
		methodChannel.setMethodCallHandler(null);
	}

	/**
	 * EventChannel
	 */
	@Override
	public void onListen(Object arguments, EventChannel.EventSink events) {

		String streamName = ((Map) arguments).get("streamName").toString();
		if (streamName.equals(Common.barcodeReader_addResultlistener)) {
			textResultStream = events;
			DynamsoftSDKManager.manager().textResultCallBack(textResultStream);
		}

	}

	@Override
	public void onCancel(Object arguments) {

	}

	/**
	 * MethodChannel
	 */
	@Override
	public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

		switch (call.method) {
			/// DBR
			case Common.barcodeReader_initLicense:
				barcodeReaderInitLicense(call.arguments, result);
				break;
			case Common.barcodeReader_createInstance:
				barcodeReaderCreateInstance(call.arguments, result);
				break;
			case Common.barcodeReader_getVersion:
				barcodeReaderGetVersion(call.arguments, result);
				break;
			case Common.barcodeReader_startScanning:
				barcodeReaderStartScanning(call.arguments, result);
				break;
			case Common.barcodeReader_stopScanning:
				barcodeReaderStopScanning(call.arguments, result);
				break;
			case Common.barcodeReader_updateRuntimeSettings:
				barcodeReaderUpdateRuntimeSettings(call.arguments, result);
				break;
			case Common.barcodeReader_getRuntimeSettings:
				barcodeReaderGetRuntimeSettings(call.arguments, result);
				break;
			case Common.barcodeReader_updateRuntimeSettingsFromTemplate:
				barcodeReaderUpdateRuntimeSettingsFromTemplate(call.arguments, result);
				break;
			case Common.barcodeReader_updateRuntimeSettingsFromJson:
				barcodeReaderUpdateRuntimeSettingsFromJson(call.arguments, result);
				break;
			case Common.barcodeReader_resetRuntimeSettings:
				barcodeReaderResetRuntimeSettings(call.arguments, result);
				break;
			case Common.barcodeReader_outputRuntimeSettingsToString:
				barcodeReaderOutputRuntimeSettingsToString(call.arguments, result);
				break;
			case Common.barcodeReader_decodeFile:
				barcodeReaderDecodeFile(call.argument("flutterAssetsPath"), result);
				break;
			case Common.barcodeReader_enableResultVerification:
				barcodeReaderEnableResultVerification((boolean) call.arguments);
				result.success(null);
				break;

			/// DCE
			case Common.cameraEnhancer_createInstance:
				cameraEnhancerCreateInstance(Common.pluginActivity, result);
				break;
			case Common.cameraEnhancer_dispose:
				cameraEnhancerDispose(call.arguments, result);
				break;
			case Common.cameraEnhancer_setScanRegion:
				cameraEnhancerSetScanRegion(call.arguments, result);
				break;
			case Common.cameraEnhancer_setScanRegionVisible:
				cameraEnhancerSetScanRegionVisible(call.arguments, result);
				break;
			case Common.cameraEnhancer_setOverlayVisible:
				cameraEnhancerSetOverlayVisible(call.arguments, result);
				break;
			case Common.cameraEnhancer_openCamera:
				cameraEnhancerOpenCamera(result);
				break;
			case Common.cameraEnhancer_closeCamera:
				cameraEnhancerCloseCamera(result);
				break;
			case Common.cameraEnhancer_selectCamera:
				try {
					cameraEnhancerSelectCamera((Integer) call.arguments);
				} catch (CameraEnhancerException e) {
					e.printStackTrace();
				}
				result.success(null);
				break;
			case Common.cameraEnhancer_turnOnTorch:
				try {
					cameraEnhancerTurnOnTorch();
				} catch (CameraEnhancerException e) {
					e.printStackTrace();
				}
				result.success(null);
				break;
			case Common.cameraEnhancer_turnOffTorch:
				try {
					cameraEnhancerTurnOffTorch();
				} catch (CameraEnhancerException e) {
					e.printStackTrace();
				}
				result.success(null);
				break;
			case Common.cameraView_torchButton:
				HashMap<String, Integer> rect = call.argument("rect");
				Integer x = null;
				Integer y = null;
				Integer width = null;
				Integer height = null;
				if (rect != null) {
					x = rect.get("x");
					y = rect.get("y");
					width = rect.get("width");
					height = rect.get("height");
				}
				String openImgPath = call.argument("torchOnImage");
				String closeImgPath = call.argument("torchOffImage");
				Boolean visible = false;
				if (call.argument("visible") != null) {
					if (call.argument("visible") instanceof Boolean) {
						visible = call.argument("visible");
					}
				}
				try {
					cameraViewTorchButton(visible, x, y, width, height, openImgPath, closeImgPath);
				} catch (IOException e) {
					e.printStackTrace();
				}
				result.success(null);
				break;

			/// Navigation and lifecycle methods
//			case Common.navigation_didPushNext:
//				navigationDidPushNext(result);
//				break;
//			case Common.navigation_didPopNext:
//				navigationDidPopNext(result);
//				break;
//			case Common.appState_becomeResumed:
//				appStateBecomeResumed(result);
//				break;
//			case Common.appState_becomeInactive:
//				appStateBecomeInactive(result);
//				break;

			default:
				result.notImplemented();
		}

	}

	/// DBR methods
	private void barcodeReaderInitLicense(Object arguments, Result result) {
		DynamsoftSDKManager.manager().barcodeReaderInitLicense(arguments, result);
	}

	private void barcodeReaderCreateInstance(Object arguments, Result result) {
		DynamsoftSDKManager.manager().barcodeReaderCreateInstance(arguments, result);
	}

	private void barcodeReaderGetVersion(Object arguments, Result result) {
		result.success(BarcodeReader.getVersion());
	}

	private void barcodeReaderStartScanning(Object arguments, Result result) {

		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			DynamsoftSDKManager.manager().barcodeReader.setCameraEnhancer(DynamsoftSDKManager.manager().cameraEnhancer);
		}
		DynamsoftSDKManager.manager().barcodeReader.startScanning();

		result.success(null);
	}

	private void barcodeReaderStopScanning(Object arguments, Result result) {
		DynamsoftSDKManager.manager().barcodeReader.stopScanning();
		result.success(null);
	}

	private void barcodeReaderUpdateRuntimeSettings(Object arguments, Result result) {

		try {
			PublicRuntimeSettings runtimeSettings = DynamsoftConvertManager.manager().aynlyzeRuntimeSettingsFromJson(arguments);
			DynamsoftSDKManager.manager().barcodeReader.updateRuntimeSettings(runtimeSettings);
			result.success(null);
		} catch (BarcodeReaderException e) {

			result.error(Common.exceptionTip, e.getMessage(), null);
		}
	}

	private void barcodeReaderGetRuntimeSettings(Object arguments, Result result) {
		try {
			PublicRuntimeSettings runtimeSettings = DynamsoftSDKManager.manager().barcodeReader.getRuntimeSettings();
			result.success(DynamsoftConvertManager.manager().wrapRuntimeSettingsToJson(runtimeSettings));
		} catch (BarcodeReaderException e) {
			result.error(Common.exceptionTip, e.getMessage(), null);
		}

	}

	private void barcodeReaderUpdateRuntimeSettingsFromTemplate(Object arguments, Result result) {
		EnumPresetTemplate presetTemplate = DynamsoftConvertManager.manager().aynlyzePresetTemplateFromJson(arguments);
		DynamsoftSDKManager.manager().barcodeReader.updateRuntimeSettings(presetTemplate);

		result.success(null);
	}

	private void barcodeReaderUpdateRuntimeSettingsFromJson(Object arguments, Result result) {
		String jsonString = (String) ((Map) arguments).get("jsonString");
		try {
			DynamsoftSDKManager.manager().barcodeReader.initRuntimeSettingsWithString(jsonString
					, EnumConflictMode.CM_OVERWRITE);
			result.success(null);
		} catch (BarcodeReaderException e) {
			result.error(Common.exceptionTip, e.getMessage(), null);
		}
	}

	private void barcodeReaderResetRuntimeSettings(Object arguments, Result result) {
		try {
			DynamsoftSDKManager.manager().barcodeReader.resetRuntimeSettings();
			result.success(null);
		} catch (BarcodeReaderException e) {
			result.error(Common.exceptionTip, e.getMessage(), null);
		}
	}

	private void barcodeReaderOutputRuntimeSettingsToString(Object arguments, Result result) {

		try {
			String settingsString = DynamsoftSDKManager.manager().barcodeReader.outputSettingsToString("");
			result.success(settingsString);
		} catch (BarcodeReaderException e) {
			result.error(Common.exceptionTip, e.getMessage(), null);
		}
	}

	private void barcodeReaderDecodeFile(String flutterAssetsPath, Result result) {
		if (DynamsoftSDKManager.manager().barcodeReader != null) {
			if (flutterAssets != null) {
				String path = flutterAssets.getAssetFilePathBySubpath(flutterAssetsPath);
				try {
//					InputStream is = assetManager.open(path);
//					TextResult[] results = DynamsoftSDKManager.manager().barcodeReader.decodeFileInMemory(is);
					TextResult[] results = DynamsoftSDKManager.manager().barcodeReader.decodeFile(flutterAssetsPath);
					if (results != null && results.length > 0) {
						result.success(DynamsoftConvertManager.manager().wrapResultsToJson(results));
					} else {
						result.success(null);
					}
					return;
				} catch (BarcodeReaderException e) {
					e.printStackTrace();
				}
			}
		}
		result.error("-10000", "Decode file failed.", null);
	}

	private void barcodeReaderEnableResultVerification(boolean enabled) {
		if (DynamsoftSDKManager.manager().barcodeReader != null) {
			DynamsoftSDKManager.manager().barcodeReader.enableResultVerification(enabled);
		}
	}

	/// DCE methods

	private void cameraEnhancerCreateInstance(Activity activity, Result result) {
		if (activity != null) {
			DynamsoftSDKManager.manager().cameraEnhancer = new CameraEnhancer(activity);
			if (DynamsoftSDKManager.manager().cameraView != null) {
				DynamsoftSDKManager.manager().cameraEnhancer.setCameraView(DynamsoftSDKManager.manager().cameraView);
			}
		}
		result.success(null);
	}

	private void cameraEnhancerDispose(Object arguments, Result result) {
		if (DynamsoftSDKManager.manager().barcodeReader != null) {
			DynamsoftSDKManager.manager().barcodeReader.stopScanning();
		}

		try {
			DynamsoftSDKManager.manager().cameraEnhancer.close();
		} catch (CameraEnhancerException e) {
			e.printStackTrace();
		}
		DynamsoftSDKManager.manager().cameraEnhancer = null;

		result.success(null);
	}

	private void cameraEnhancerSetScanRegion(Object arguments, Result result) {
		RegionDefinition regionDefinition = ((Map) arguments).get("scanRegion") == null ? null : DynamsoftConvertManager.manager().aynlyzeiRegionDefinitionFromJson(arguments);

		try {
			DynamsoftSDKManager.manager().cameraEnhancer.setScanRegion(regionDefinition);
			result.success(null);
		} catch (CameraEnhancerException e) {
			result.error(Common.exceptionTip, e.getMessage(), null);
		}
	}

	private void cameraEnhancerSetScanRegionVisible(Object arguments, Result result) {

		boolean scanRegionVisible = (boolean) ((Map) arguments).get("isVisible");
		DynamsoftSDKManager.manager().cameraEnhancer.setScanRegionVisible(scanRegionVisible);
		result.success(null);
	}

	private void cameraEnhancerSetOverlayVisible(Object arguments, Result result) {
		boolean overlayVisible = (boolean) ((Map) arguments).get("isVisible");
		DynamsoftSDKManager.manager().cameraView.setOverlayVisible(overlayVisible);
		result.success(null);
	}

	private void cameraEnhancerOpenCamera(Result result) {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			try {
				DynamsoftSDKManager.manager().cameraEnhancer.open();
				result.success(null);
			} catch (CameraEnhancerException e) {
				result.success(null);
			}
		}
	}

	private void cameraEnhancerCloseCamera(Result result) {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			try {
				DynamsoftSDKManager.manager().cameraEnhancer.close();
				result.success(null);
			} catch (CameraEnhancerException e) {
				result.success(null);
			}
		}
	}

	private void cameraEnhancerSelectCamera(int position) throws CameraEnhancerException {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			switch (position) {
				case 1:
					DynamsoftSDKManager.manager().cameraEnhancer.selectCamera(EnumCameraPosition.CP_FRONT);
					break;
				case 0:
				default:
					DynamsoftSDKManager.manager().cameraEnhancer.selectCamera(EnumCameraPosition.CP_BACK);
			}
		}
	}

	private void cameraEnhancerTurnOnTorch() throws CameraEnhancerException {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			DynamsoftSDKManager.manager().cameraEnhancer.turnOnTorch();
		}
	}

	private void cameraEnhancerTurnOffTorch() throws CameraEnhancerException {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			DynamsoftSDKManager.manager().cameraEnhancer.turnOffTorch();
		}
	}

	private void cameraViewTorchButton(Boolean visible, Integer x, Integer y, Integer width, Integer height, String openImgPath, String closeImgPath) throws IOException {
		if (DynamsoftSDKManager.manager().cameraView != null) {
			if (DynamsoftSDKManager.manager().cameraView != null) {
				if (x != null && y != null && width != null && height != null) {
					Drawable openImg = null;
					Drawable closeImg = null;

					if (openImgPath != null) {
						String path = flutterAssets.getAssetFilePathBySubpath(openImgPath);
						InputStream is = assetManager.open(path);
						openImg = BitmapDrawable.createFromStream(is, null);
						is.close();
					}
					if (closeImgPath != null) {
						String path = flutterAssets.getAssetFilePathBySubpath(closeImgPath);
						InputStream is = assetManager.open(path);
						closeImg = BitmapDrawable.createFromStream(is, null);
						is.close();
					}
					DynamsoftSDKManager.manager().cameraView.setTorchButton(new Point(x, y), width, height, openImg, closeImg);
				}
				DynamsoftSDKManager.manager().cameraView.setTorchButtonVisible(visible);

			}
		}
	}


	/// Navigation and lifecycle methods
	private void navigationDidPopNext(Result result) {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			try {
				DynamsoftSDKManager.manager().cameraEnhancer.open();
				result.success(null);
			} catch (CameraEnhancerException e) {
				result.error(Common.exceptionTip, e.getMessage(), null);
			}
		}
	}

	private void navigationDidPushNext(Result result) {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			try {
				DynamsoftSDKManager.manager().cameraEnhancer.close();
				result.success(null);
			} catch (CameraEnhancerException e) {
				result.error(Common.exceptionTip, e.getMessage(), null);
			}
		}
	}

	private void appStateBecomeResumed(Result result) {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			try {
				DynamsoftSDKManager.manager().cameraEnhancer.open();
				result.success(null);

			} catch (CameraEnhancerException e) {
				result.error(Common.exceptionTip, e.getMessage(), null);
			}
		}

	}

	private void appStateBecomeInactive(Result result) {
		if (DynamsoftSDKManager.manager().cameraEnhancer != null) {
			try {
				DynamsoftSDKManager.manager().cameraEnhancer.close();
				result.success(null);
			} catch (CameraEnhancerException e) {
				result.error(Common.exceptionTip, e.getMessage(), null);
			}
		}
	}

}
