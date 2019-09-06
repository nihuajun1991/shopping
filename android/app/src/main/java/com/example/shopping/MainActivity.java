package com.example.shopping;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
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
import android.widget.Toast;

public class MainActivity extends FlutterActivity {
private static  final  String TAG= "MainActivity";
  private static final String CHANNEL = "lingjuan/channel";
  private static final String TAOBAO = "taobao";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(),CHANNEL).setMethodCallHandler(
      new MethodCallHandler(){
        @Override
        public void onMethodCall(MethodCall call, Result result) {
          if (call.method.equals("lingjuan")) {  
            try{
             // result.success("571395305551");
                if(call.argument("id")!=null){
                    //showTaobaoDetail(MainActivity.this,call.argument("id"));
                    String url2 = call.argument("id");
                    Log.d(TAG,url2);
                    if (isAppInstalled(MainActivity.this, "com.taobao.taobao")) {
                        Intent intent2 = getPackageManager().getLaunchIntentForPackage("com.taobao.taobao"); //这行代码比较重要
                        intent2.setAction("android.intent.action.VIEW");
                        intent2.setClassName("com.taobao.taobao", "com.taobao.browser.BrowserActivity");
                        Uri uri = Uri.parse(url2);
                        intent2.setData(uri);
                        startActivity(intent2);
                    }

                }

            }catch(Exception e){
               Toast.makeText(MainActivity.this,"aaaa",Toast.LENGTH_SHORT).show();
            }
           
             //result.success("571395305551");
        } else {
            result.notImplemented();
        }
      }
      }
    );
  }



    private boolean isAppInstalled(Context context, String uri) {
        PackageManager pm = context.getPackageManager();
        boolean installed = false;
        try {
            pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
            installed = true;
        } catch (PackageManager.NameNotFoundException e) {
            installed = false;
        }
        return installed;
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
        alibcTaokeParams.adzoneid = "109378300241";
        alibcTaokeParams.pid = "mm_46748349_644650418_109378300241";
        //alibcTaokeParams.subPid = "mm_46748349_644650418_109378300241";
        alibcTaokeParams.extraParams = new HashMap();
        alibcTaokeParams.extraParams.put("taokeAppkey","27708881");
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
