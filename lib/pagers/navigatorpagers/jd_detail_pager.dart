import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shancheng/bean/detailbean.dart';
import 'package:shancheng/bean/goods_detail_bean.dart';
import 'package:shancheng/bean/goodsbean.dart';
import 'package:shancheng/bean/jd_detailbean.dart';
import 'package:shancheng/bean/jd_pagerbean.dart';
import 'package:shancheng/bean/pdd_detail_bean.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:shancheng/view/webview.dart';
import 'package:url_launcher/url_launcher.dart';

class JDDetailPager extends StatefulWidget {
  final JDPagerData data;

  JDDetailPager({Key key, this.data, }) : super(key: key);

  _JDDetailPagerState createState() =>
      _JDDetailPagerState(data: data);
}

class _JDDetailPagerState extends State<JDDetailPager>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  static const platform = const MethodChannel('lingjuan/channel');
  var text;
  final JDPagerData data;
  final double juanjia;
  GoodsDetailBean goodsbean;
  GoodsDetails detail;
  List<ImageList> swiperImageList = [];
  var detailHtml;
  var webviewurl='';

  // NTbkItem nTbkItem;
  String _batteryLevel = '';

  _JDDetailPagerState({this.data, this.juanjia});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }

    super.didChangeAppLifecycleState(state);
  }


  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }



  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    _getGoodsDetail(data.skuId);
    print("skuId:" + data?.skuId);
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    //print("dispose");
    super.dispose();
  }







  void _getGoodsDetail(itemNumId) {
    getJDGoodsDetail(itemNumId).then((value) {
      if (value.toString().length > 0) {
        var jsonstr = json.decode(value.toString());
        var bean = JDDetail.fromJson(jsonstr);
        _getGoodsLink(itemNumId,bean.data[0].couponInfo.couponList.length>0?bean.data[0].couponInfo.couponList[0].link:'');
        print("jsonstr:"+jsonstr.toString());

        setState(() {

          swiperImageList = bean?.data[0].imageInfo.imageList;

          //webviewurl  = bean?.data[0].materialUrl;

          //detail = bean?.goodsDetailResponse?.goodsDetails[0];

        });
      }
    });
  }


  void _getGoodsLink(String skuId, String couponUrl){
    getJDGoodslink(skuId,couponUrl).then((value){
      if (value.toString().length > 0) {
        var jsonstr = json.decode(value.toString());
        print("jsonstr:"+jsonstr.toString());
        setState(() {
          webviewurl = jsonstr['data']['shortURL'];
        });

      }
    });
  }

  Widget _getDetail() {
    if (swiperImageList.length>0) {
      return Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.all(5.0),
          child: Column(
            children:_getjddetail(),
          ));
    } else {
      return Text('');
    }
  }

  List<Widget> _getjddetail(){
    return swiperImageList.map((value){
      return  Container(
        child: Image.network(value.url),
      );
    }) .toList();


  }


  Widget _goodsTitle(JDPagerData data) {
    if (data != null) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //劵后价
              Container(
                margin: EdgeInsets.all(5),
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: "劵后价  ",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(25),
                              color: Colors.red,
                              fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: "¥",
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(25),
                              color: Colors.red,
                              fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: data.wlPriceAfter,
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              color: Colors.red,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  "原价："+data.wlPrice,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(22),
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey,
                      decorationStyle: TextDecorationStyle.solid),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  data.skuName,
                  style:
                  TextStyle(fontSize: ScreenUtil.getInstance().setSp(25)),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("测试"),
        // ),
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                child: EasyRefresh.builder(
                    builder: (context, physics, header, footer) {
                      return CustomScrollView(
                        physics: physics,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate([
                              SwiperDiy(
                                swiperDateList: swiperImageList,
                              ),
                            ]),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              _goodsTitle(data),
                            ]),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              _getDetail(),
                            ]),
                          ),
                        ],
                      );
                    }),
              ),
              Positioned(
                bottom: 0,
                child: InkWell(
                    onTap: () {
                      //_openOtherApp();

                      //_getPDDShare();
                      if(webviewurl!=null&&webviewurl.length>0){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WebView(
                                        url: webviewurl,
                                        statusBarColor: "ffffff",
                                        title: "京东",
                                        backForbid: true,
                                        hideAppBar: false,
                                      )));
                        }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white]), //背景渐变
                              borderRadius: BorderRadius.circular(3.0), //3像素圆角
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black54,
                                    offset: Offset(3.0, 1.0),
                                    blurRadius: 4.0)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 18.0),
                            child: Text(
                              "领劵",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize:
                                  ScreenUtil.getInstance().setSp(25.0)),
                            ),
                          )),
                    )),
              ),
              //返回按钮
              Positioned(
                  top: MediaQueryData.fromWindow(window).padding.top,
                  left: 0,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(10.0)),
                      decoration: BoxDecoration(
                          color: Colors.black54, shape: BoxShape.circle),
                      child: Icon(
                        Icons.navigate_before,
                        size: 35.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class SwiperDiy extends StatelessWidget {
  final List<ImageList> swiperDateList;

  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("swiperDateList的长度:${swiperDateList.length}");
    return Container(
      height: ScreenUtil.getInstance().setWidth(800),
      width: ScreenUtil.getInstance().setWidth(800),
      child: ScrollNotificationInterceptor(
        child: _getswiper(swiperDateList),
      ),
    );
  }

  Widget _getswiper(List<ImageList> swiperDateList) {
    if (swiperDateList.length > 0) {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDateList[index].url}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        //index :0,
        loop: true,
        autoplay: false,
      );
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: LoadDialog(
          text: 'loading',
        ),
      );
    }
  }
}
