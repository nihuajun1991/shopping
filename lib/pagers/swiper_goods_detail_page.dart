import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shopping/bean/detailbean.dart';
import 'package:shopping/bean/goods_detail_bean.dart';
import 'package:shopping/bean/goodsbean.dart';
import 'package:shopping/service/service_method.dart';
import 'package:shopping/view/loading_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SwiperGoodsDetail extends StatefulWidget{

  final String url;
  final String name;


  const SwiperGoodsDetail({Key key, this.url, this.name}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SwiperGoodsDetailState();
  }

}


class _SwiperGoodsDetailState extends State<SwiperGoodsDetail> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  var swiperImageList = [];
  String GoodsId='';
  GoodsDetailBean goodsbean;
  ShanPin detail;
  var detailHtml;
  static const platform = const MethodChannel('lingjuan/channel');

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
    //print("state:{$state}");
    super.didChangeAppLifecycleState(state);
  }


  @override
  void initState() {
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    GoodsId = widget.url.substring(widget.url.indexOf('+')+1,widget.url.length);
    //changeStatusColor(Colors.transparent);
    _getTbProductInfo(GoodsId);
    _getGoodsDetail(GoodsId);
    print("taobaoId:" + GoodsId);
  }


  void _getGoodsDetail(itemNumId) {
    getGoodsDetail1(itemNumId).then((value) {
      if (value.toString().length > 0) {
        var jsonstr = json.decode(value.toString());
        var detailBean = new DetailBean.fromJson(jsonstr);
        //print("jsonstr:${detailBean.data.pcDescContent}");
        detailHtml = detailBean.data.pcDescContent;
        //detailHtml =
        setState(() {
          detailHtml = detailHtml.replaceAll('src="', 'src="http:');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                              _goodsTitle(detail),
                            ]),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate([
                              _getDetail(detailHtml),
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
                      _openOtherApp();
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


  void _openOtherApp() async {
    if (Platform.isIOS) {
      String url = "tbopen:" + detail.couponShareUrl??detail.url;
      print("taobaourl:$url");
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      _getBatteryLevel();
    }
  }

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('lingjuan', {
        "id": "https:" + detail.couponShareUrl,
      });
      batteryLevel = '$result % ';
    } on PlatformException catch (e) {
      batteryLevel = "'${e.message}'";
    }

//    setState(() {
//      _batteryLevel = batteryLevel;
//    });
  }


  Widget _getDetail(String _detailHtml) {
    if (_detailHtml != null) {
      return Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  '详情介绍',
                  style:
                  TextStyle(fontSize: ScreenUtil.getInstance().setSp(30.0)),
                ),
              ),
              Html(
                data: _detailHtml,
              ),
            ],
          ));
    } else {
      return Text('');
    }
  }


  Widget _goodsTitle(ShanPin detail) {
    if (detail != null) {
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
                          text: (double.parse(detail.zkFinalPrice??"0")-double.parse(detail.couponAmount??"0")).toStringAsFixed(2).toString(),
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
                  "原价："+detail.zkFinalPrice,
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
                  detail.title,
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


  void _getTbProductInfo(tbId){
    getTbProductInfo(tbId.toString()).then((value){

      if(value.toString().length>0){
        var jsonstr = json.decode(value.toString());
        var bean = Goodsbean.fromJson(jsonstr);
        //print("bean:results${bean.results}");

        setState(() {
          _getShanPinDetail(bean.results?.nTbkItem?.title);
        });

      }
    });
  }


  //网络请求详情数据
  void _getShanPinDetail(title) {

    getShanPinDetail(GoodsId,title.toString(),).then((value) {
      //print("value:${value.toString()}");

      if (value.toString().length > 0) {
        var jsonstr = json.decode(value.toString());
        if(jsonstr['code']==200){
          goodsbean = new GoodsDetailBean.fromJson(jsonstr);

          setState(() {
            swiperImageList = goodsbean?.data?.smallImages?.string;

            detail = goodsbean?.data;
            print(detail.zkFinalPrice);
          });
        }else{
          print(jsonstr['msg']);
        }


      }
      // print("Info:$text");
    });
  }

}


class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

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

  Widget _getswiper(List swiperDateList) {
    if (swiperDateList.length > 0) {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDateList[index]}",
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