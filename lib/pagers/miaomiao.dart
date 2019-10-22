import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shancheng/bean/miaocategorbean.dart';
import 'package:shancheng/bean/miaoswiperbean.dart';
import 'package:shancheng/service/service_method.dart';

const APPBAR_SCROLL_OFFSET = 100;

class MiaoPage extends StatefulWidget {
  @override
  MiaoPageState createState() {
    // TODO: implement createState
    return MiaoPageState();
  }
}

class MiaoPageState extends State<MiaoPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double appBarAlpha = 0;

  MiaoCategor miaoCategor;
  List<String> taburi = [];
  bool isloading = true;
  Miaoswiper miaoswiper;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  //滚动且是列表滚动的时候
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: _listView,
            ),
          ),
          _appBar
        ],
      ),
    );
  }

  Widget get _listView {
    return ListView(children: <Widget>[
      Container(
        width: MediaQueryData.fromWindow(window).size.width,
        height: MediaQueryData.fromWindow(window).size.width * 500 / 640 + 70,
        child: Stack(
          children: <Widget>[
            _backpic,
            Positioned(
              child: Container(
                //padding: EdgeInsets.only(bottom: 20),
                child: _swiper,
              ),
              bottom: 0,
            )
          ],
        ),
      )
    ]);
  }

  Widget get _backpic {
    return Container(
      width: MediaQueryData.fromWindow(window).size.width,
      height: MediaQueryData.fromWindow(window).size.width * 500 / 640,
      child: Image.network(
        miaoCategor.data[0].bannerPath,
        fit: BoxFit.fill,
        //width: ScreenUtil.getInstance().setWidth(750),
        //ßheight: ScreenUtil.getInstance().setWidth(750),
      ),
    );
  }

  Widget get _swiper {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      height: 120,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //color: Colors.white,
            decoration: new BoxDecoration(
              border: new Border.all(width: 2.0, color: Colors.white),
              color: Colors.white,
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),

           boxShadow: [BoxShadow(
               color: Colors.black45,
               offset: Offset(0.0,2.0),
               blurRadius: 4.0, spreadRadius: 1.0),

             ] ,
            ),

            padding: EdgeInsets.all(8),
            margin:EdgeInsets.all(8) ,
            child: Row(
              children: <Widget>[
                Image.network(miaoswiper.data[index].thumb),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10),

                    child: Column(
                      children: <Widget>[
                        Text(miaoswiper.data[index].title,maxLines: 2,style: TextStyle(fontSize: 12),),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: EdgeInsets.only(top:8),
                            width: 65,
                            decoration: new BoxDecoration(
                              border: new Border.all(width: 1.0, color: Colors.red),
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                            ),
                            child:Center(
                              child:  Row(
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                    decoration: new BoxDecoration(
                                      //border: new Border.all(width: 2.0, color: Colors.red),
                                      color: Colors.red,
                                      //borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                                    ),
                                    child:  Center(
                                      child: Text('券',style: TextStyle(fontSize: 12,color: Colors.white)),
                                    ),
                                  ),

                                  Container(
                                    width:30,
                                    child:  Center(
                                      child: Text('¥ ${double.parse(miaoswiper.data[index].couponAmount).toInt()}',maxLines: 1,style: TextStyle(fontSize: 12)),
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ),
                        ),
                   Container(
                     margin: EdgeInsets.only(top:8),
                     child:  Row(
                       mainAxisAlignment:MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text('¥:${double.parse(miaoswiper.data[index].price)-double.parse(miaoswiper.data[index].couponAmount)}券后',
                             style: TextStyle(fontSize: 14,color: Colors.grey)),
                         Container(
                           height: 20,
                           width: 60,
                           decoration: new BoxDecoration(
                             //border: new Border.all(width: 2.0, color: Colors.red),
                             color: Colors.red,
                             borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                           ),
                           child: Center(
                             child: Text(
                                 '快来抢购',
                                 style: TextStyle(fontSize: 11,color: Colors.white)
                             ),
                           ),
                         )
                       ],
                     ),
                   )

                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        itemCount: miaoswiper.data.length,
        viewportFraction: 0.8,
        scale: 0.9,
        loop: false,
        controller: new SwiperController(),
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQueryData.fromWindow(window).padding.top),
            height: MediaQueryData.fromWindow(window).padding.top + 90,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xaaFFFFFF),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black12,
                          //阴影颜色
                          blurRadius: 2.0, //阴影大小
                        ),
                      ],
                      borderRadius: BorderRadius.circular(18),
                      border: Border(
                          // top:BorderSide(width: 0.5, color: Colors.black) ,
                          // bottom: BorderSide(width: 0.5, color: Colors.black),
                          )),
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.search,
                    color: Colors.pink,
                    size: 30,
                  ),
                ),
                Container(
                  height: 30,
                  child: Center(
                    child: tabbar,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
            height: appBarAlpha > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

  Widget get tabbar {
    if (!isloading) {
      List<Widget> listWidget = [];
      if (taburi != null && taburi.length > 0) {
        taburi.forEach((item) {
          listWidget.add(InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              // color:item.color,
              width: 80,
              //height:ScreenUtil.getInstance().setWidth(40) ,
              margin: EdgeInsets.all(1),
              //padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50),right: ScreenUtil.getInstance().setWidth(50),top: 0,bottom: 0),
              child: Text(
                item.toString(),
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ));
        });

        return Container(
          margin: EdgeInsets.fromLTRB(
              ScreenUtil.getInstance().setWidth(10),
              ScreenUtil.getInstance().setWidth(10),
              ScreenUtil.getInstance().setWidth(10),
              0),
          //color: Colors.white,
          width: ScreenUtil.getInstance().setWidth(750),
          height: ScreenUtil.getInstance().setWidth(60),
          child: ListView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: listWidget,
          ),
        );
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {}
    //print("state:{$state}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    _getCategories();
  }

  _getCategories() {
    getCategories().then((value) {
      print(value.toString());
      var jsonstr = json.decode(value.toString());
      miaoCategor = new MiaoCategor.fromJson(jsonstr);

      if (miaoCategor.data.length > 0) {
        miaoCategor.data.forEach((item) {
          taburi.add(item.name);
        });
      }

      setState(() {
        if (taburi.length > 0) {
          isloading = false;
          _getSwiper(miaoCategor.data[0].id);
        }
      });
    });
  }

  _getSwiper(int id) {
    getSwiper(id).then((value) {
      var jsonstr = json.decode(value.toString());

      setState(() {
        if (jsonstr.toString().length > 0) {
          miaoswiper = Miaoswiper.fromJson(jsonstr);
        }
      });
    });
  }
}
