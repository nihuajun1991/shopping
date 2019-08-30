import 'dart:convert'; 

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  var page = 0;
  List<Data> shanPinList = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('重新加载');
    _getShanpinPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("百姓生活+"),
      // ),
      body: EasyRefresh(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: getHomePagerContent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print("data:"+snapshot.data['data'].toString());
                  List swiper;
                  if (snapshot.data != null) {
                    if (snapshot.data['data'].toString().length > 0) {
                      swiper = (snapshot.data['data'] as List);
                    }
                  }

                  //print("swiper" + swiper.toString());
                  return Column(
                    children: <Widget>[
                      SwiperDiy(
                        swiperDateList: swiper,
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Text('加载中'),
                  );
                }
              },
            ),
            FutureBuilder(
              future: getHomeOrderImg(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //print("data:"+snapshot.data['data'].toString());
                  List navigatorList;
                  if (snapshot.data != null) {
                    if (snapshot.data['data1'].toString().length > 0) {
                      navigatorList = (snapshot.data['data1'] as List);
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
            AnimateText(),
            FutureBuilder(
              future: getHotList(),
              builder: (context, snapshot) {
                //print("hotList" + snapshot.data['hotList'].toString());
                if (snapshot.hasData) {
                  List recommendList;
                  if (snapshot.data != null) {
                    if (snapshot.data['data1'].toString().length > 0) {
                      recommendList = (snapshot.data['hotList'] as List);
                    }
                  }
                  return Column(
                    children: <Widget>[
                      Recommend(
                        recommendList: recommendList,
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
            _hotGoods(),
          ],
        ),
        onLoad: () async {
          print('加载更多');
          await getShanPinList(pager:page).then((value) {
            var beanstr = json.decode(value.toString());
            var bean = new ShanpinBean.fromJson(beanstr);
            List<Data> newShanpinList = bean.proList.data;
            setState(() {
              shanPinList.addAll(newShanpinList);
              page++;
            });
          });
        },
        // onRefresh: () async {
        //   print('刷新');
        // },
        header: BallPulseHeader(),
        footer: BallPulseFooter(),
        
      ),
    );
  }

  //获取火爆专区商品
  void _getShanpinPage() {
    getShanPinList(pager:page).then((value) {
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
    margin: EdgeInsets.only(top: 10.0),
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
          onTap: () {},
          child: Container(
            width: ScreenUtil.getInstance().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
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
                  width: ScreenUtil.getInstance().setWidth(372),
                  child: Text(
                    item.bussName,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil.getInstance().setSp(22)),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(100),
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
      height: ScreenUtil.getInstance().setWidth(750)*340/780,
      width: ScreenUtil.getInstance().setWidth(780),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return 
          
Image.network(
            "${swiperDateList[index]['content']}",
            fit: BoxFit.fill,
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
        },
        child: Column(
          children: <Widget>[
            Image.network(item['content'],height: ScreenUtil.getInstance().setHeight(80),width: ScreenUtil.getInstance().setWidth(80),),
            Text(item['name'],style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20.0)),),
          ],
        )
        );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      navigatorList.removeRange(10, this.navigatorList.length);
    }

    // return Scaffold(
    //   body: GridView.count(
    //     physics: NeverScrollableScrollPhysics(),
    //     crossAxisCount: 5, //每行5个
    //     padding: EdgeInsets.all(5.0),
    //     children: navigatorList.map((item) {
    //       return _gridViewItemUI(context, item);
    //     }).toList(),
    //   ),
    // );
    
    

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
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil.getInstance().setHeight(300),
        width: ScreenUtil.getInstance().setWidth(250),
        padding: EdgeInsets.all(8.0),
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
              style: TextStyle(fontSize:ScreenUtil.getInstance().setSp(20.0)),
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
                        style: TextStyle(fontSize:ScreenUtil.getInstance().setSp(20.0)),
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
                          style: TextStyle(color: Colors.white,fontSize:ScreenUtil.getInstance().setSp(20.0)),
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
      height: ScreenUtil.getInstance().setHeight(330),
      child: ListView.builder(
    
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(400),
      //margin: EdgeInsets.only(top:10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}
