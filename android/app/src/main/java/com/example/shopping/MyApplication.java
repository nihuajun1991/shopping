package com.example.shopping;

import android.app.Application;
import android.util.Log;


import com.alibaba.baichuan.android.trade.AlibcTradeSDK;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeInitCallback;
import io.flutter.app.FlutterApplication;

import java.util.HashMap;

public class MyApplication extends FlutterApplication {
    private static  final  String TAG= "MyApplication";

    @Override
    public void onCreate() {
        super.onCreate();
        //FlutterMain.startInitialization(app);
        initAlibcTradeSDK();
    }



    private void initAlibcTradeSDK(){
        //AlibcTradeCommon.turnOnDebug();
        //AlibcTradeBiz.turnOnDebug();


        //电商SDK初始化
//        AlibcTradeSDK.asyncInit(this, new AlibcTradeInitCallback() {
//            @Override
//            public void onSuccess() {
//                Log.d(TAG,"初始化阿里百川成功");
////                Toast.makeText(RHApplication.this, "初始化成功", Toast.LENGTH_SHORT).show();
////                Map utMap = new HashMap<>();
////                utMap.put("debug_api_url","http://muvp.alibaba-inc.com/online/UploadRecords.do");
////                utMap.put("debug_key","baichuan_sdk_utDetection");
////                UTTeamWork.getInstance().turnOnRealTimeDebug(utMap);
////                AlibcUserTracker.getInstance().sendInitHit4DAU("19","3.1.1.100");
//
//            }
//
//            @Override
//            public void onFailure(int code, String msg) {
//                Log.d(TAG,"初始化阿里百川失败,错误码="+code+" / 错误消息="+msg);
//            }
//        });
    }
}