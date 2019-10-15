import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shancheng/pagers/goodsdetail.dart';
import 'package:shancheng/pagers/navigatorpagers/jd_pager.dart';
import 'package:shancheng/pagers/navigatorpagers/ju_pager.dart';
import 'package:shancheng/pagers/navigatorpagers/nine_pager.dart';
import 'package:shancheng/pagers/navigatorpagers/pdd_pager.dart';
import 'package:shancheng/pagers/swiper_goods_detail_page.dart';

import 'package:shancheng/view/webview.dart';

import '../service/service_method.dart';
import 'package:transparent_image/transparent_image.dart';
import '../bean/shanpinbean.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = "正在获取数据";
  var page = 1;
  bool isHasNext = true;

  List<Data> shanPinList = [];
  List swiperlist = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('重新加载');
    _getShanpinPage();
    _getHomePagerContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.builder(
          header: BallPulseHeader(),
          footer: BallPulseFooter(),
          onLoad: () async {
            print('加载更多-----page:$page');
            if (isHasNext) {
              await getShanPinList(pager: page).then((value) {
               // print('value-----value:' + value.toString());

                var beanstr = json.decode(value.toString());
                var bean = new ShanpinBean.fromJson(beanstr);
                List<Data> newShanpinList = bean.proList.data;
                if (null == bean.proList.nextPageUrl) {
                  isHasNext = false;
                }
                setState(() {
                  shanPinList.addAll(newShanpinList);
                  page++;
                });
              });
            }
          },
          builder: (context, physics, header, footer) {
            return CustomScrollView(
              physics: physics,
              slivers: <Widget>[
                // SliverList(
                //   delegate: SliverChildListDelegate([
                //     Container(
                //       height: 210.0,
                //       child: ScrollNotificationInterceptor(
                //         child: Swiper(
                //           itemBuilder: (BuildContext context, int index) {
                //             return Image.network(
                //               "${swiperlist[index]['content']}",
                //               fit: BoxFit.fill,
                //             );
                //           },
                //           itemCount: swiperlist.length !=0 ?swiperlist.length:0,
                //           viewportFraction: 0.8,
                //           scale: 0.9,
                //           autoplay: true,
                //         ),
                //       ),
                //     ),
                //   ]),
                // ),

                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      height:
                          ScreenUtil.getInstance().setWidth(750) * 340 / 780,
                      width: ScreenUtil.getInstance().setWidth(780),
                      child: ScrollNotificationInterceptor(
                        child: _swiperWdiget(),
                      ),
                    )
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    FutureBuilder(
                      future: getHomeOrderImg(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                           var jsonstr = json.decode(snapshot.data.toString());
                         // print("jsonstr:"+jsonstr.toString());
                          List navigatorList;
                          if (jsonstr!= null) {
                            if (jsonstr.length > 0) {
                              navigatorList = (jsonstr['data1'] as List);
                            }
                          }
                          return Column(
                            children: <Widget>[
                              TopNavigator(
                                navigatorList: navigatorList,
                              )
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(''),
                          );
                        }
                      },
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    AnimateText(),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    FutureBuilder(
                      future: getHotList(),
                      builder: (context, snapshot) {
                        //print("hotList" + snapshot.data['hotList'].toString());
                        if (snapshot.hasData) {
                          List recommendList;
                          if (snapshot.data != null) {
                            if (snapshot.data['data1'].toString().length > 0) {
                              recommendList =
                                  (snapshot.data['hotList'] as List);
                            }
                          }
                          return Recommend(
                            recommendList: recommendList,
                          );

//                            Column(
//                            children: <Widget>[
//                              Recommend(
//                                recommendList: recommendList,
//                              )
//                            ],
//                          );
                        } else {
                          return Center(
                            child: Text(''),
                          );
                        }
                      },
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    _hotGoods(),
                  ]),
                ),
                footer
              ],
            );
          }),

//      EasyRefresh(
//        child: ListView(
//          children: <Widget>[
//            FutureBuilder(
//              future: getHomePagerContent(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  //print("data:"+snapshot.data['data'].toString());
//                  List swiper;
//                  if (snapshot.data != null) {
//                    if (snapshot.data['data'].toString().length > 0) {
//                      swiper = (snapshot.data['data'] as List);
//                    }
//                  }
//
//                  //print("swiper" + swiper.toString());
//                  return Column(
//                    children: <Widget>[
//                      SwiperDiy(
//                        swiperDateList: swiper,
//                      )
//                    ],
//                  );
//                } else {
//                  return Center(
//                    child: Text('加载中'),
//                  );
//                }
//              },
//            ),
//            FutureBuilder(
//              future: getHomeOrderImg(),
//              builder: (context, snapshot) {
//                if (snapshot.hasData) {
//                  //print("data:"+snapshot.data['data'].toString());
//                  List navigatorList;
//                  if (snapshot.data != null) {
//                    if (snapshot.data['data1'].toString().length > 0) {
//                      navigatorList = (snapshot.data['data1'] as List);
//                    }
//                  }
//                  return Column(
//                    children: <Widget>[
//                      TopNavigator(
//                        navigatorList: navigatorList,
//                      )
//                    ],
//                  );
//                } else {
//                  return Center(
//                    child: Text(''),
//                  );
//                }
//              },
//            ),
//            AnimateText(),
//            FutureBuilder(
//              future: getHotList(),
//              builder: (context, snapshot) {
//                //print("hotList" + snapshot.data['hotList'].toString());
//                if (snapshot.hasData) {
//                  List recommendList;
//                  if (snapshot.data != null) {
//                    if (snapshot.data['data1'].toString().length > 0) {
//                      recommendList = (snapshot.data['hotList'] as List);
//                    }
//                  }
//                  return Column(
//                    children: <Widget>[
//                      Recommend(
//                        recommendList: recommendList,
//                      )
//                    ],
//                  );
//                } else {
//                  return Center(
//                    child: Text(''),
//                  );
//                }
//              },
//            ),
//            _hotGoods(),
//          ],
//        ),
//        onLoad: () async {
//          print('加载更多');
//          await getShanPinList(pager: page).then((value) {
//            var beanstr = json.decode(value.toString());
//            var bean = new ShanpinBean.fromJson(beanstr);
//            List<Data> newShanpinList = bean.proList.data;
//            setState(() {
//              shanPinList.addAll(newShanpinList);
//              page++;
//            });
//          });
//        },
//        // onRefresh: () async {
//        //   print('刷新');
//        // },
//        header: BallPulseHeader(),
//        footer: BallPulseFooter(),
//      ),
    );
  }

  Widget _swiperWdiget() {
    if (swiperlist != null && swiperlist.length > 0) {
      return ScrollNotificationInterceptor(
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                print(swiperlist[index].toString());

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SwiperGoodsDetail(
                      url:swiperlist[index]['url'],
                      name:swiperlist[index]['name'],
                  );
                }));
              },
              child:  Image.network(
                "${swiperlist[index]['content']}",
                fit: BoxFit.fill,
              ),
            );
          },
          itemCount: swiperlist.length,
          pagination: SwiperPagination(),
          autoplay: true,
        ),
      );
    } else {
      return Text('');
    }
  }

  void _getHomePagerContent() {
    getHomePagerContent().then((value) {
     // print("swiper:" + value['data'].toString());

      setState(() {
        if (null != value['data']) {
          swiperlist.addAll(value['data']);
        }
      });
    });
  }

  //获取火爆专区商品
  void _getShanpinPage() {
    getShanPinList(pager: page).then((value) {
      var beanstr = json.decode(value.toString());
      var bean = new ShanpinBean.fromJson(beanstr);
      List<Data> newShanpinList = bean.proList.data;
      setState(() {
        shanPinList.addAll(newShanpinList);
        page++;
      });
    });
  }

  //首页商品展示
  Widget _ShanPinTitle = Container(
    margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(10.0)),
    alignment: Alignment.center,
    color: Colors.white,
    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "🔥火爆专区",
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        )
      ],
    ),
  );

   


  Widget _wrapList() {
    if (shanPinList.length > 0) {
      List<Widget> listWidget = [];
      shanPinList.forEach((item) {
        listWidget.add(InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return GoodsDetail(
                data: item,
                juanjia: (double.parse(item.quanFee)),
              );
            }));
             
             //_openOtherApp();

          },
          child: Container(
            width: ScreenUtil.getInstance().setWidth(352),
            //color: Colors.white,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      //offset: Offset(0.0,0.0),
                      blurRadius: 1.0)
                ]),
            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(10)),
            margin: EdgeInsets.fromLTRB(
                ScreenUtil.getInstance().setWidth(10),
              ScreenUtil.getInstance().setWidth(10),
              ScreenUtil.getInstance().setWidth(5),
              ScreenUtil.getInstance().setWidth(10)
            ),
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
                                color: Color(0xffec6900),
                                fontSize: ScreenUtil.getInstance().setSp(22))),
                        TextSpan(
                            text: "  券后",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: ScreenUtil.getInstance().setSp(18)))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      });

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text("");
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          _ShanPinTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

//轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  const SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setWidth(750) * 340 / 780,
      width: ScreenUtil.getInstance().setWidth(780),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){

            },
            child: Image.network(
              "${swiperDateList[index]['content']}",
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;
  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
        onTap: () {
          print("点击了导航");
//         Navigator.push(context, WebView());

          if (null != item['url'] && item['url'].toString().contains("http")) {
            String url = item['url'].toString().substring(
                item['url'].toString().indexOf("http"), item['url']
                .toString()
                .length);
            print(url);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        WebView(
                          url: url,
                          statusBarColor: "ffffff",
                          title: item['name'],
                          backForbid: true,
                          hideAppBar: false,
                        )));
          }

          if (null != item['url'] && item['url'].toString().contains("bkb")) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NinePager()
              ),
            );
          }

          if(null!= item['url'] &&item['url'].toString().contains("pdd")){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PDDPager()
              ),
            );

          }

          if(null!= item['url'] &&item['url'].toString().contains("jhs")){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JHSPager()
              ),
            );

          }

          if(null!= item['url'] &&item['url'].toString().contains("jd")){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JdPager()
              ),
            );

          }


        },

        child: Column(
          children: <Widget>[
            Image.network(
              item['content'],
              height: ScreenUtil.getInstance().setHeight(80),
              width: ScreenUtil.getInstance().setWidth(80),
            ),
            Text(
              item['name'],
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20.0)),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      navigatorList.removeRange(10, this.navigatorList.length);
    }

//     return Scaffold(
//
//       body: GridView.count(
//         physics: NeverScrollableScrollPhysics(),
//         crossAxisCount: 5, //每行5个
//         padding: EdgeInsets.all(5.0),
//         children: navigatorList.map((item) {
//           return _gridViewItemUI(context, item);
//         }).toList(),
//       ),
//     );

//    return Row(
//      children: <Widget>[
//        Expanded(
//          child: GridView.count(
//            physics: NeverScrollableScrollPhysics(),
//            crossAxisCount: 5, //每行5个
//            padding: EdgeInsets.all(5.0),
//            children: navigatorList.map((item) {
//              return _gridViewItemUI(context, item);
//            }).toList(),
//          ),
//        )
//      ],
//    );

    return Container(
      height: ScreenUtil.getInstance().setHeight(280),
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5, //每行5个
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AnimateText extends StatelessWidget {
  final String str = "晒后美白就需这几步";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 3.0, right: 20.0, bottom: 3.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Icon(Icons.voicemail),
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, top: 0.0, right: 0.0, bottom: 0.0),
              child: Text(
                str,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}) : super(key: key);

  //推荐商品标题
  Widget _titleWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(10.0)),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          )),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //推荐商品
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        //print("recommendList:"+recommendList.toString());
        Data data = new Data(
          id: recommendList[index]['id'],
          bussName: recommendList[index]['buss_name'],
          taobaoId: recommendList[index]['taobao_id'],
          pic: recommendList[index]['pic'],
          couponLink: recommendList[index]['couponLink'],
          shoujia: recommendList[index]['shoujia'],
          juanhou: recommendList[index]['juanhou'],
          quanFee: recommendList[index]['quan_fee'],
          sales: recommendList[index]['sales'],
          commissionRate: recommendList[index]['commission_rate'],
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
        //height: ScreenUtil.getInstance().setHeight(300),
        width: ScreenUtil.getInstance().setWidth(250),
        padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Column(
          children: <Widget>[
            Container(
              height: ScreenUtil.getInstance().setHeight(180),
              width: ScreenUtil.getInstance().setWidth(250),
              color: Colors.white,
              child: new FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: recommendList[index]['pic'],
              ),
            ),
            Text(
              recommendList[index]['buss_name'],
              maxLines: 2,
              style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20.0)),
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              height: ScreenUtil.getInstance().setHeight(40),
              width: ScreenUtil.getInstance().setWidth(250),
              margin: EdgeInsets.only(top: 10.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '¥${double.parse(recommendList[index]['juanhou']).round()}',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(20.0)),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Container(
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
                        //color: Colors.red,
                        child: Text(
                          '券${double.parse(recommendList[index]['quan_fee']).toInt()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil.getInstance().setSp(20.0)),
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(310)+ScreenUtil.getInstance().setSp(20.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _titleWidget(),
        _recommendList(),
      ],
    );

//      Container(
//      height: ScreenUtil.getInstance().setHeight(360),
//      margin: EdgeInsets.only(top:ScreenUtil.getInstance().setHeight(10.0)),
//      child: Column(
//        children: <Widget>[
//          _titleWidget(),
//          _recommendList(),
//        ],
//      ),
//    );
  }
}
