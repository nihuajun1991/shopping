package com.nihuajun.shancheng

import android.annotation.TargetApi
import android.content.Context
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  private val TAG = "MainActivity"
  private val CHANNEL = "lingjuan/channel"
  private val TAOBAO = "taobao"

  @TargetApi(Build.VERSION_CODES.CUPCAKE)
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "lingjuan") {
        try {
          // result.success("571395305551");
          if (call.argument<Any>("id") != null) {
            //showTaobaoDetail(MainActivity.this,call.argument("id"));
            val url2 = call.argument<String>("id")
            Log.d(TAG, url2)
            if (isAppInstalled(this@MainActivity, "com.taobao.taobao")) {
              val intent2 = packageManager.getLaunchIntentForPackage("com.taobao.taobao") //这行代码比较重要
              intent2!!.action = "android.intent.action.VIEW"
              intent2.setClassName("com.taobao.taobao", "com.taobao.browser.BrowserActivity")
              val uri = Uri.parse(url2)
              intent2.data = uri
              startActivity(intent2)
            }

          }

        } catch (e: Exception) {
          Toast.makeText(this@MainActivity, "aaaa", Toast.LENGTH_SHORT).show()
        }

        //result.success("571395305551");
      } else {
        result.notImplemented()
      }
    }

  }


  private fun isAppInstalled(context: Context, uri: String): Boolean {
    val pm = context.packageManager
    var installed = false
    try {
      pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES)
      installed = true
    } catch (e: PackageManager.NameNotFoundException) {
      installed = false
    }

    return installed
  }
}
