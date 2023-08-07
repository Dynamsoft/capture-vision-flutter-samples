package com.dynamsoft.dcv.flutter.capture_view;

import android.app.Activity;
import android.content.Context;
import android.view.View;

import com.dynamsoft.dce.CameraEnhancer;
import com.dynamsoft.dce.CameraEnhancerException;
import com.dynamsoft.dce.DCECameraView;

import io.flutter.plugin.platform.PlatformView;

import com.dynamsoft.dcv.flutter.handles.DynamsoftSDKManager;

public class BarcodeScanningCaptureView implements PlatformView {

    public BarcodeScanningCaptureView(Context context) {

        DynamsoftSDKManager.manager().cameraView = new DCECameraView(context);
        if(DynamsoftSDKManager.manager().cameraEnhancer != null){
            DynamsoftSDKManager.manager().cameraEnhancer.setCameraView(DynamsoftSDKManager.manager().cameraView);
        }
    }

    @Override
    public View getView() {
        return DynamsoftSDKManager.manager().cameraView;
    }

    @Override
    public void dispose() {
        DynamsoftSDKManager.manager().cameraView = null;
    }

}
