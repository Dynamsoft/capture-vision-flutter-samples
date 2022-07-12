package com.dynamsoft.dcv.flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.StandardMessageCodec;

import com.dynamsoft.dcv.flutter.Common;
import com.dynamsoft.dcv.flutter.DynamsoftCaptureVisionFactory;

/**
 * DynamsoftCaptureVisionFlutterPlugin
 */
public class DynamsoftCaptureVisionFlutterPlugin implements FlutterPlugin, ActivityAware {
	private DynamsoftCaptureVisionFactory barcodeFactory;

	/**
	 * FlutterPlugin
	 */
	@Override
	public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

		barcodeFactory = new DynamsoftCaptureVisionFactory(new StandardMessageCodec(), flutterPluginBinding);

		flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(Common.platformFactory_identifier, barcodeFactory);
	}

	@Override
	public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
		barcodeFactory.dipose();
	}

	/**
	 * ActivityAware
	 */
	@Override
	public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {

		Common.pluginActivity = binding.getActivity();
	}

	@Override
	public void onDetachedFromActivityForConfigChanges() {

	}

	@Override
	public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

	}

	@Override
	public void onDetachedFromActivity() {
		Common.pluginActivity = null;
	}
}
