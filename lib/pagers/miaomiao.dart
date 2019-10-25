import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shancheng/bean/miaocategorbean.dart';
import 'package:shancheng/bean/miaomiaoarticle.dart';
import 'package:shancheng/bean/miaoswiperbean.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/pagers/goodsdetail.dart';
import 'package:shancheng/pagers/miaomiaocontent_pager.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:shancheng/view/tbsearchwidget.dart';
import 'package:transparent_image/transparent_image.dart';

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
  List<MMArticleData> mmArticleData = [];
  MiaoCategor miaoCategor;
  List<MiaoCategorData> taburi = [];
  bool isloading = true;
  Miaoswiper miaoswiper;
  //SwiperData data; //当前显示哪一块数据，用这个对像保存
  String bicuri;

  int id; //表示当前页面的id
  int page = 1;

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
      body: !isloading
          ? Stack(
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
                    child: _body,
                  ),
                ),
                _appBar
              ],
            )
          : LoadDialog(),
    );
  }

  Widget get _body {
    return EasyRefresh.custom(

      slivers: <Widget>[
                  SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: MediaQueryData.fromWindow(window).size.width,
                height:
                    MediaQueryData.fromWindow(window).size.width * 500 / 640 +
                        70,
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
              ),
            ]),
          ),
                  SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return MiaoMiaoContent(
                        data: mmArticleData[index],
                      );
                    }));
                  },
                  child: _listviewitem(context, mmArticleData[index]),
                );
              },
              childCount: mmArticleData.length,
            ),
          ),

      ],
      header: PhoenixHeader(),
      footer: PhoenixFooter(),
      onLoad: () async {
        print('加载更多-----page:$page');

        getMMArticle(id, page).then((value) {
          var jsonstr = json.decode(value.toString());
          var mMArticle = MMArticle.fromJson(jsonstr);
          print("mMArticle" + mMArticle.data[0].body);
          setState(() {
            mmArticleData.addAll(mMArticle.data);
            isloading = false;
            page++;
          });
        });
      },
      onRefresh: () async {
        page = 1;
        //_getCategories();
        _getSwiper(id);
      },
    );
  }

  Widget get _backpic {
    return Container(
      width: MediaQueryData.fromWindow(window).size.width,
      height: MediaQueryData.fromWindow(window).size.width * 500 / 640,
      child: Image.network(
        bicuri,
        fit: BoxFit.fill,
        //width: ScreenUtil.getInstance().setWidth(750),
        //height: ScreenUtil.getInstance().setWidth(750),
      ),
    );
  }

  Widget get _swiper {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      height: 120,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              Data data = new Data(
                id: int.parse(miaoswiper.data[index].id),
                bussName: miaoswiper.data[index].title,
                taobaoId: miaoswiper.data[index].taobaoId,
                pic: miaoswiper.data[index].thumb,
                couponLink: miaoswiper.data[index].couponUrl,
                shoujia: miaoswiper.data[index].price,
                juanhou: (double.parse(miaoswiper.data[index].price) - double.parse(miaoswiper.data[index].couponAmount)).toStringAsFixed(2),
                quanFee: miaoswiper.data[index].couponAmount,
                sales: miaoswiper.data[index].sales,
                commissionRate: miaoswiper.data[index].commissionRate,
              );
              //print("data:" + data.toString());
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GoodsDetail(
                  data: data,
                  juanjia: double.parse(data.quanFee),
                );
              }));
            },
            child: Container(
              //color: Colors.white,
              decoration: new BoxDecoration(
                border: new Border.all(width: 2.0, color: Colors.white),
                color: Colors.white,
                borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 4.0,
                      spreadRadius: 1.0),
                ],
              ),

              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Image.network(miaoswiper.data[index].thumb),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            miaoswiper.data[index].title,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                margin: EdgeInsets.only(top: 8),
                                width: 65,
                                decoration: new BoxDecoration(
                                  border: new Border.all(
                                      width: 1.0, color: Colors.red),
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                ),
                                child: Center(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 30,
                                        decoration: new BoxDecoration(
                                          //border: new Border.all(width: 2.0, color: Colors.red),
                                          color: Colors.red,
                                          //borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                                        ),
                                        child: Center(
                                          child: Text('券',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      Container(
                                        width: 30,
                                        child: Center(
                                          child: Text(
                                              '¥ ${double.parse(miaoswiper.data[index].couponAmount).toInt()}',
                                              maxLines: 1,
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    '¥:${(double.parse(miaoswiper.data[index].price) - double.parse(miaoswiper.data[index].couponAmount)).toStringAsFixed(2)}券后',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                Container(
                                  height: 20,
                                  width: 60,
                                  decoration: new BoxDecoration(
                                    //border: new Border.all(width: 2.0, color: Colors.red),
                                    color: Colors.red,
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10.0)),
                                  ),
                                  child: Center(
                                    child: Text('快来抢购',
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white)),
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
    List<Widget> listWidget = [];
    if (taburi != null && taburi.length > 0) {
      taburi.forEach((item) {
        listWidget.add(InkWell(
          onTap: () {
            if (id != item.id) {
              setState(() {
                bicuri = item.bannerPath;
                id = item.id;
                isloading = true;
              });
              mmArticleData.clear();

              _getSwiper(item.id);
            }
          },
          child: Container(
            alignment: Alignment.center,
            // color:item.color,
            width: 80,
            //height:ScreenUtil.getInstance().setWidth(40) ,
            margin: EdgeInsets.all(1),
            //padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50),right: ScreenUtil.getInstance().setWidth(50),top: 0,bottom: 0),
            child: Text(
              item.name,
              style: TextStyle(
                  color: Color.fromARGB(
                      (255).toInt(),
                      ((1 - appBarAlpha) * 255).toInt(),
                      ((1 - appBarAlpha) * 255).toInt(),
                      ((1 - appBarAlpha) * 255).toInt()),
                  fontSize: 15),
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

  Widget _listviewitem(BuildContext context, MMArticleData data) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _itemtitle(data),
          Container(
            width: MediaQueryData.fromWindow(window).size.width,
            height: MediaQueryData.fromWindow(window).size.width * 358 / 638,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.coverPath),
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: (data.videoPath != null && data.videoPath.length > 0)
                ? Icon(Icons.video_label)
                : Text(''),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            alignment: Alignment.centerLeft,
            child: Text(
              data.title,
              maxLines: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            alignment: Alignment.centerLeft,
            child: Text(
              data.summary,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemtitle(MMArticleData data) {
    return Container(
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
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      data.authorInfo.author,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                    margin: EdgeInsets.only(left: 10),
                    child: Text('#' + data.categoryInfo.name,
                        style: TextStyle(fontSize: 12, color: Colors.red)),
                  )
                ],
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(data.authorInfo.introduction,
                      style: TextStyle(fontSize: 12, color: Colors.grey))),
            ],
          )
        ],
      ),
    );
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
      //print(value.toString());
      var jsonstr = json.decode(value.toString());
      miaoCategor = new MiaoCategor.fromJson(jsonstr);

      if (miaoCategor.data.length > 0) {
        miaoCategor.data.forEach((item) {
          taburi.add(item);
        });
      }

      setState(() {
        if (taburi.length > 0) {
          id = miaoCategor.data[0].id;
          bicuri = miaoCategor.data[0].bannerPath; //默认显示第一张
          _getSwiper(id);
        }
      });
    });
  }

  _getSwiper(int id) {
    getSwiper(id).then((value) {
      var jsonstr = json.decode(value.toString());
      print("getSwiper" + jsonstr.toString());
      setState(() {
        _getMMArticle(id);
        if (jsonstr.toString().length > 0) {
          miaoswiper = Miaoswiper.fromJson(jsonstr);
          //data = miaoswiper.data[0];
        }
      });
    });
  }

  _getMMArticle(int id) {
    getMMArticle(id, page).then((value) {
      var jsonstr = json.decode(value.toString());
      var mMArticle = MMArticle.fromJson(jsonstr);
      print("mMArticle" + mMArticle.data[0].body);
      setState(() {
        mmArticleData.addAll(mMArticle.data);
        isloading = false;
        page++;
      });
    });
  }
}
