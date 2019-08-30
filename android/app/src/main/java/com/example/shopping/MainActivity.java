package com.example.shopping;

import android.os.Bundle;
import android.app.Activity;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.alibaba.baichuan.trade.biz.context.AlibcTradeResult;
import com.alibaba.baichuan.android.trade.AlibcTrade;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeCallback;
import com.alibaba.baichuan.android.trade.AlibcTradeSDK;
import com.alibaba.baichuan.android.trade.callback.AlibcTradeInitCallback;

import com.alibaba.baichuan.trade.biz.core.taoke.AlibcTaokeParams;
import com.alibaba.baichuan.trade.biz.AlibcConstants;
import com.alibaba.baichuan.android.trade.page.AlibcDetailPage;
import com.alibaba.baichuan.android.trade.page.AlibcBasePage;
import com.alibaba.baichuan.android.trade.model.AlibcShowParams;
import com.alibaba.baichuan.android.trade.model.OpenType;
import android.util.Log;
import java.util.HashMap;

public class MainActivity extends FlutterActivity {
private static  final  String TAG= "MainActivity";
  private static final String CHANNEL = "samples.flutter.io/battery";
  private static final String TAOBAO = "taobao";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(
      new MethodCallHandler(){
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if (call.method.equals("getBatteryLevel")) {  
           showTaobaoDetail(MainActivity.this,"571395305551");
             //result.success("571395305551");
        } else {
            result.notImplemented();
        }
      }
      }
    );
  }

 private void showDetailPage(Activity activity , String id ,String type ){
        AlibcShowParams alibcShowParams = null;
        switch (type){
            case TAOBAO:
                alibcShowParams =  new AlibcShowParams(OpenType.Native, false);
                alibcShowParams.setClientType("taobao_scheme")  ;
                break;
            case "2":

                break;
            case "3":

                break;
            default:

        }
        AlibcDetailPage alibcBasePage = new AlibcDetailPage(id);
        HashMap exParams = new HashMap();
        exParams.put(AlibcConstants.ISV_CODE, "appisvcode");
        AlibcTaokeParams alibcTaokeParams =new AlibcTaokeParams();
        // adzoneid 为mm_memberId_siteId_adzoneId最后一位
        alibcTaokeParams.adzoneid = "109217350018";
        alibcTaokeParams.pid = "mm_46748349_644650418_109217350018";
        alibcTaokeParams.subPid = "mm_46748349_644650418_109217350018";
        alibcTaokeParams.extraParams = new HashMap();
        alibcTaokeParams.extraParams.put("taokeAppkey","27863805");
        AlibcTrade.show(
                activity,
                alibcBasePage,
                alibcShowParams,
                alibcTaokeParams,
                exParams,
                new AlibcTradeCallback(){

                    @Override
                    public void onTradeSuccess(AlibcTradeResult alibcTradeResult) {

                    }

                    @Override
                    public void onFailure(int i, String s) {

                    }
                }
        );

    }


    private void showTaobaoDetail(Activity activity, String id) {

        showDetailPage(activity, id, TAOBAO);

    }
  //private void  showDetailPage
}
