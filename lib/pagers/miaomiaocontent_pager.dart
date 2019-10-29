import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_properties.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shancheng/bean/miaomiaoarticle.dart';
import 'package:shancheng/bean/miaomiaocontentbean.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/pagers/goodsdetail.dart';
import 'package:shancheng/pagers/videopager.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/myappbar.dart';
import 'package:shancheng/view/tbsearchwidget.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:html/dom.dart' as dom;

const APPBAR_SCROLL_OFFSET = 100;

class MiaoMiaoContent extends StatefulWidget {
  final MMArticleData data;
  const MiaoMiaoContent({Key key, this.data}) : super(key: key);

  @override
  _MiaoMiaoContentState createState() {
    return _MiaoMiaoContentState();
  }
}

class _MiaoMiaoContentState extends State<MiaoMiaoContent> {
  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  double appBarAlpha = 0;
  bool isVideo = false;
  bool isLoading = true;
  String html;
  List<Products> products;

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
    //print(appBarAlpha);
  }

  _getMMArticleInfo() {
    getMMArticleInfo(widget.data.id).then((value) {
      //print(value.toString());
      var jsonstr = json.decode(value.toString());
      MiaoContentbean bean = MiaoContentbean.fromJson(jsonstr);
      setState(() {
        products = bean.data.products;
        isLoading = false;
        html = bean.data.body;
      });
    });
  }

  @override
  void initState() {
    //print('_MiaoMiao:'+widget.data.body);
    super.initState();
    _getMMArticleInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: MAppBar(
//        child: _appBar,
//      ),
        key: _globalKey,
        endDrawer: Drawer(

            child: Container(
          padding: EdgeInsets.only(
              top: MediaQueryData.fromWindow(window).padding.top+10),
          height: MediaQueryData.fromWindow(window).size.height,
          width: MediaQueryData.fromWindow(window).size.width,

          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(10),

                  child: Text(
                    '文中商品',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              products != null
                  ? new Flexible(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                              children: products.map<Widget>((item) {
                            return InkWell(
                              onTap: () {
                                Data data = new Data(
                                  id: int.parse(item.id),
                                  bussName: item.title,
                                  taobaoId: item.taobaoId,
                                  pic: item.thumb,
                                  couponLink: item.couponUrl,
                                  shoujia: item.price,
                                  juanhou: (double.parse(item.price) -
                                          double.parse(item.couponAmount))
                                      .toStringAsFixed(2),
                                  quanFee: item.couponAmount,
                                  sales: item.sales,
                                  commissionRate: item.commissionRate,
                                );
                                //print("data:" + data.toString());
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return GoodsDetail(
                                    data: data,
                                    juanjia: double.parse(item.couponAmount),
                                  );
                                }));
                              },
                              child: Container(
                                //color: Colors.white,
                                decoration: new BoxDecoration(
                                  border: new Border.all(
                                      width: 2.0, color: Colors.white),
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(10.0)),
//                                  boxShadow: [
//                                    BoxShadow(
//                                        color: Colors.black45,
//                                        offset: Offset(0.0, 2.0),
//                                        blurRadius: 4.0,
//                                        spreadRadius: 1.0),
//                                  ],
                                ),

                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(8),
                                height: 100,
                                child: Row(
                                  children: <Widget>[
                                    Image.network(item.thumb),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              item.title,
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 8),
                                                  width: 65,
                                                  decoration: new BoxDecoration(
                                                    border: new Border.all(
                                                        width: 1.0,
                                                        color: Colors.red),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        new BorderRadius.all(
                                                            new Radius.circular(
                                                                5.0)),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: 30,
                                                          decoration:
                                                              new BoxDecoration(
                                                            //border: new Border.all(width: 2.0, color: Colors.red),
                                                            color: Colors.red,
                                                            //borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                                                          ),
                                                          child: Center(
                                                            child: Text('券',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 30,
                                                          child: Center(
                                                            child: Text(
                                                                '¥ ${double.parse(item.couponAmount).toInt()}',
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                      '¥:${(double.parse(item.price) - double.parse(item.couponAmount)).toStringAsFixed(2)}券后',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey)),
                                                  Container(
                                                    height: 20,
                                                    width: 60,
                                                    decoration:
                                                        new BoxDecoration(
                                                      //border: new Border.all(width: 2.0, color: Colors.red),
                                                      color: Colors.red,
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                              new Radius
                                                                      .circular(
                                                                  10.0)),
                                                    ),
                                                    child: Center(
                                                      child: Text('快来抢购',
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: Colors
                                                                  .white)),
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
                              ),
                            );
                          }).toList())))
                  : Text('无')
            ],
          ),
        )),
        body: Container(
          padding: EdgeInsets.only(
              top: MediaQueryData.fromWindow(window).padding.top),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              //_body,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //_appBar,
                        InkWell(
                          onTap: () {
                            if (widget.data.videoPath != null &&
                                widget.data.videoPath.length > 0) {
//                            Navigator.push(context, MaterialPageRoute(builder: (context) {
//                              return VideoApp(
//                                videouri: widget.data.videoPath,
//                              );
//                            }));
                              setState(() {
                                isVideo = true;
                              });
                            }
                          },
                          child: !isVideo
                              ? Container(
                                  width: MediaQueryData.fromWindow(window)
                                      .size
                                      .width,
                                  height: MediaQueryData.fromWindow(window)
                                          .size
                                          .width *
                                      358 /
                                      638,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(widget.data.coverPath),
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: (widget.data.videoPath != null &&
                                          widget.data.videoPath.length > 0)
                                      ? Icon(Icons.video_label)
                                      : Text(''),
                                )
                              : Container(
                                  width: MediaQueryData.fromWindow(window)
                                      .size
                                      .width,
                                  height: MediaQueryData.fromWindow(window)
                                          .size
                                          .width *
                                      358 /
                                      638,
                                  child:
                                      VideoApp(videouri: widget.data.videoPath),
                                ),
                        ),
                        _itemtitle(widget.data),
                        _contenttitle,
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Html(
                            data: widget.data.body ?? '',
                            imageProperties: new ImageProperties(scale: 2),
                            padding: EdgeInsets.all(8.0),
                            linkStyle: const TextStyle(
                              color: Colors.redAccent,
                              decorationColor: Colors.redAccent,
                              decoration: TextDecoration.underline,
                            ),
                            onLinkTap: (url) {
                              print("Opening $url...");
                            },
                            onImageTap: (src) {
                              print(src);
                            },
                            customRender: (node, children) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "custom_tag":
                                    return Column(children: children);
                                }
                              }
                              return null;
                            },
                            customTextAlign: (dom.Node node) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "p":
                                    return TextAlign.justify;
                                }
                              }
                              return null;
                            },
                            customTextStyle:
                                (dom.Node node, TextStyle baseStyle) {
                              if (node is dom.Element) {
                                switch (node.localName) {
                                  case "p":
                                    return baseStyle.merge(
                                        TextStyle(height: 2, fontSize: 20));
                                }
                              }
                              return baseStyle;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                  top: MediaQueryData.fromWindow(window).size.height / 2,
                  right: 10,
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(10.0)),
                      decoration: BoxDecoration(
                          color: Colors.orange, shape: BoxShape.rectangle),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '提到的商品',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      _globalKey.currentState.openEndDrawer();
                      // Navigator.pop(context);
                    },
                  )),

              Positioned(
                  top: 10,
                  left: 10,
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
        ));
  }

  Widget get _contenttitle {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQueryData.fromWindow(window).size.width,
            child: Text(
              widget.data.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            width: MediaQueryData.fromWindow(window).size.width,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/yanjing.png',
                  width: 20,
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(widget.data.views),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'assets/love.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(widget.data.likes),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              //AppBar渐变遮罩背景
//              colors: [Color(0x66000000), Colors.transparent],
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter,
//            ),
              color: Colors.white),
          child: Container(
//            padding: EdgeInsets.only(
//                top: MediaQueryData.fromWindow(window).padding.top),
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print("点击搜索框");
                    showSearch(context: context, delegate: SearchBarDelegate());
                  },
                  child: Container(
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
                ),
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

  Widget _itemtitle(MMArticleData data) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: MediaQueryData.fromWindow(window).size.width,
      height: 70,
      child: Row(
        children: <Widget>[
          ClipOval(
            child: new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, //预览图
              fit: BoxFit.fitWidth,
              image: data.authorInfo.avatar,
              width: 60.0,
              height: 60.0,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQueryData.fromWindow(window).size.width - 60,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      data.authorInfo.author,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
//                  Container(
//                    padding: EdgeInsets.only(top: 12),
//                    margin: EdgeInsets.only(left: 10),
//                    child: Text('#' + data.categoryInfo.name,
//                        style: TextStyle(fontSize: 12, color: Colors.red)),
//                  )
                ],
              ),
              Container(
                  width: MediaQueryData.fromWindow(window).size.width - 60,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 10, left: 10),
                  child: Text(data.authorInfo.introduction,
                      style: TextStyle(fontSize: 12, color: Colors.grey))),
            ],
          )
        ],
      ),
    );
  }
}
