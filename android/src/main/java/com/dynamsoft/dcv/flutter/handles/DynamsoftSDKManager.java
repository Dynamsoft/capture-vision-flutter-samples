package com.dynamsoft.dcv.flutter.handles;

import java.util.HashMap;
import java.util.Map;

import com.dynamsoft.dbr.BarcodeReader;
import com.dynamsoft.dbr.BarcodeReaderException;
import com.dynamsoft.dbr.DBRLicenseVerificationListener;
import com.dynamsoft.dbr.ImageData;
import com.dynamsoft.dbr.TextResult;
import com.dynamsoft.dbr.TextResultListener;
import com.dynamsoft.dce.CameraEnhancer;
import com.dynamsoft.dcv.flutter.Common;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class DynamsoftSDKManager {

    public BarcodeReader barcodeReader;
    public CameraEnhancer cameraEnhancer;
    public boolean barcodeReaderLinkCameraEnhancerIsFinished;

    private volatile  static DynamsoftSDKManager manager;
    private DynamsoftSDKManager() {};

    public  static DynamsoftSDKManager manager() {
        if (manager == null) {
            synchronized (DynamsoftSDKManager.class) {
                if (manager == null) {
                    manager = new DynamsoftSDKManager();
                }
            }
        }
        return manager;
    }

    /**
     * DynamsoftBarcodeReader textResultCallBack
     * */
    public void textResultCallBack(EventChannel.EventSink textResultStream) {

        TextResultListener textResultListener = new TextResultListener() {
            @Override
            public void textResultCallback(int i, ImageData imageData, TextResult[] textResults) {

                if (Common.pluginActivity != null) {

                    Common.pluginActivity.runOnUiThread(new Runnable() {
                        @Override
                        public void run() {

                            textResultStream.success(DynamsoftConvertManager.manager().wrapResultsToJson(textResults));

                        }
                    });

                }

            }
        };

        DynamsoftSDKManager.manager().barcodeReader.setTextResultListener(textResultListener);


    }

    /**
     * DynamsoftBarcodeReader initLicense
     * */
    public void barcodeReaderInitLicense(Object arguments, MethodChannel.Result resultMethod) {
        String license = ((Map)arguments).get("license").toString();
        BarcodeReader.initLicense(license, new DBRLicenseVerificationListener() {
            @Override
            public void DBRLicenseVerificationCallback(boolean b, Exception e) {
                String errorMsg = "";
                if (!b) {
                    errorMsg = e.getMessage();
                }

                HashMap<String, Object> licenseDic = new HashMap<>();
                licenseDic.put("isSuccess", b);
                licenseDic.put("errorString", errorMsg);

                Common.pluginActivity.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        resultMethod.success(licenseDic);
                    }
                });
            }
        });
    }

    /**
     * DBR createInstance
     */
    public void barcodeReaderCreateInstance(Object arguments, MethodChannel.Result resultMethod) {
        try {
            DynamsoftSDKManager.manager().barcodeReader = new BarcodeReader();
        } catch (BarcodeReaderException e) {
            e.printStackTrace();
        }

        resultMethod.success(null);
    }


}
