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

    public DCECameraView cameraView;

    public BarcodeScanningCaptureView(Activity context) {

        cameraView = new DCECameraView(context);
        DynamsoftSDKManager.manager().cameraEnhancer = new CameraEnhancer(context);
        DynamsoftSDKManager.manager().cameraEnhancer.setCameraView(cameraView);
        try {
            DynamsoftSDKManager.manager().cameraEnhancer.open();
        } catch (CameraEnhancerException e) {
            e.printStackTrace();
        }

    }

    @Override
    public View getView() {
        return cameraView;
    }

    @Override
    public void dispose() {

    }

}
