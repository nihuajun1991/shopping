import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shopping/bean/ninebean.dart';
import 'package:shopping/bean/shanpinbean.dart';
import 'package:shopping/pagers/goodsdetail.dart';
import 'package:shopping/service/service_method.dart';
import 'package:shopping/view/loading_dialog.dart';
import 'package:transparent_image/transparent_image.dart';

class NinePager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NinePager();
  }
}

class _NinePager extends State<NinePager>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  List<NineData> _nineBean=[];
  bool isload = false;
  int pagerindex = 1;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Color(int.parse("0xffffffff")));
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
    //print("state:{$state}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    isload = true;
    _NinePagerData();
    FlutterStatusbarcolor.setStatusBarColor(Color(int.parse("0xffffffff")));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(int.parse("0xffffffff")),
        padding:
            EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        child: Column(
          children: <Widget>[_Title(),
            _ShanPinList()],
        ));
  }

  _NinePagerData() {
    getNinePagerContent(0, 9.9,pagerindex).then((value) {
      print(value.toString());
      var jsonstr = json.decode(value.toString());
      var bean = NineBean.fromJson(jsonstr);
      _nineBean.addAll(bean.proList.data);
      pagerindex++;
      setState(() {
        isload = false;

      });
    });
  }

  Widget _ShanPinList() {
    return  Expanded(
      child: Container(
        color: Color(int.parse("0xffeeeeee")),
        child: EasyRefresh(
            header: BallPulseHeader(),
            footer: BallPulseFooter(),
            onLoad: () async {
              _NinePagerData();
            },
          child: GridView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: _nineBean.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 5 / 7,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  print("点击了");
                  Data data = new Data(
                    id: _nineBean[index].id,
                    bussName: _nineBean[index].bussName,
                    taobaoId: _nineBean[index].taobaoId,
                    pic: _nineBean[index].pic,
                    couponLink: _nineBean[index].couponLink,
                    shoujia: _nineBean[index].shoujia,
                    juanhou: _nineBean[index].juanhou,
                    quanFee: _nineBean[index].quanFee,
                    sales: _nineBean[index].sales,
                    commissionRate: _nineBean[index].commissionRate,
                  );
                  //print("data:" + data.toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GoodsDetail(
                      data: data,
                      juanjia: double.parse(data.quanFee),
                    );
                  }));
                },
                child: _item(_nineBean[index], index),
              );

            },
          ),


        ),
      ),


    );






  }

  Widget _item(NineData item, int index) {
    return Container(
      //width: ScreenUtil.getInstance().setWidth(352),

      //color: Colors.white,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
//          boxShadow: [
//            BoxShadow(
//                color: Colors.white,
//                //offset: Offset(1, 1),
//                blurRadius: 1.0),
//            BoxShadow(
//                color: Colors.white,
//                //offset: Offset(-1, -1),
//                blurRadius: 1.0)
//          ]
          ),
      padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
      margin: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(10),
          index <= 1
              ? ScreenUtil.getInstance().setWidth(10)
              : ScreenUtil.getInstance().setWidth(5),
          ScreenUtil.getInstance().setWidth(5),
          ScreenUtil.getInstance().setWidth(10)),
      child: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil.getInstance().setHeight(300),
            color: Colors.white,
            child: new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: item.pic,
            ),
          ),
          Container(
            width: ScreenUtil.getInstance().setWidth(352),
            child: Text(
              item.bussName,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: ScreenUtil.getInstance().setSp(22)),
            ),
          ),
          Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    //width: ScreenUtil.getInstance().setWidth(100),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.red, //阴影颜色
                            blurRadius: 2.0, //阴影大小
                          ),
                        ],
                        border: Border.all(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(3.0)),
                    padding: EdgeInsets.all(3.0),
                    margin: EdgeInsets.only(top: 5.0),
                    //color: Colors.red,
                    child: Text(
                      '券  ¥${double.parse(item.quanFee).toInt()}',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: ScreenUtil.getInstance().setSp(22)),
                    ),
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(3.0),
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "销量${item.sales}",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: ScreenUtil.getInstance().setSp(22)),
                    ),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 5),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "¥${item.juanhou}",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xffec6900),
                          fontSize: ScreenUtil.getInstance().setSp(22))),
                  TextSpan(
                      text: "  券后",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black38,
                          fontSize: ScreenUtil.getInstance().setSp(18)))
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _Title() {
    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().setHeight(60),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.navigate_before,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                '9.9包邮',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
