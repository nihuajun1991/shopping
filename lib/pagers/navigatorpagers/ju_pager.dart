import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shancheng/bean/jhs_goods_bean.dart';
import 'package:shancheng/bean/pdd_bean.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/bean/tabbar_bean.dart';
import 'package:shancheng/pagers/navigatorpagers/pdd_categroy.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:shancheng/view/myappbar.dart';
import 'package:transparent_image/transparent_image.dart';

import '../goodsdetail.dart';



 enum JHSType{
   ju,tqg,hot
 }

class JHSPager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _JHSPagerState();
}

class _JHSPagerState extends State<JHSPager>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  JHSType type = JHSType.ju;
  int pager = 1;
 // JHSGoodsBean bean = new JHSGoodsBean();
  List<JHSData>  beans =new List();

  TabBar_Bean tabBar_Bean = new TabBar_Bean();

  bool istabloading = true;

  String cid ='';



  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    _getTabs();
    //_getPDDTab();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.white);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
    print("state:{$state}");
    super.didChangeAppLifecycleState(state);
  }





  void _getJHSGoods(String page,JHSType type,String cid){
    print('pager:$page,type:$type');

    String jhstype = 'ju';
    if(type==JHSType.ju){
      jhstype = 'ju';
    }else if(type==JHSType.tqg){
      jhstype = 'tqg';
    }else{
      jhstype = 'hot';
    }
    getJHSGoods(page,jhstype,cid:cid).then((value){

      if(value.toString().length>0){
        var jsonstr = json.decode(value.toString());
        JHSGoodsBean bean=JHSGoodsBean.fromJson(jsonstr);
        //print(bean.proList.toString());

        setState(() {
          beans.addAll(bean.proList.data);
          pager++;
        });
      }


    });
  }


  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: MAppBar(
          child: _Title(),
        ),
        body: EasyRefresh(
          header: BezierCircleHeader(),
          footer: BezierBounceFooter(),
          onRefresh: () async{
            String jhstype = 'ju';
            if(type==JHSType.ju){
              jhstype = 'ju';
            }else if(type==JHSType.tqg){
              jhstype = 'tqg';
            }else{
              jhstype = 'hot';
            }
            getJHSGoods(pager.toString(),jhstype,cid:cid??"").then((value){
              if(value.toString().length>0){
                var jsonstr = json.decode(value.toString());
                JHSGoodsBean bean=JHSGoodsBean.fromJson(jsonstr);
                //print(bean.proList.toString());
                beans.clear();
                setState(() {
                  beans.addAll(bean.proList.data);
                  pager=1;
                });
              }
            });
          },

          onLoad: () async{
            String jhstype = 'ju';
            if(type==JHSType.ju){
              jhstype = 'ju';
            }else if(type==JHSType.tqg){
              jhstype = 'tqg';
            }else{
              jhstype = 'hot';
            }
            getJHSGoods(pager.toString(),jhstype,cid: cid??'').then((value){
              if(value.toString().length>0){
                var jsonstr = json.decode(value.toString());
                JHSGoodsBean bean=JHSGoodsBean.fromJson(jsonstr);
                //print(bean.proList.toString());

                setState(() {
                  if(null!=bean.proList.data){
                    beans.addAll(bean.proList.data);
                    pager++;
                  }

                });
              }
            });
          },
          child: ListView(
            children: <Widget>[
              _JHSDCategroy,
              tabbar,
              _wrapList()
            ],
          ),
        ),
      );
  }

  Widget get _JHSDCategroy {
    BorderSide borderSide =  BorderSide(color:Colors.black12);
    BorderSide redBorderSide = BorderSide(color:Colors.red);

    return Container(
      color: Colors.white,
      width: ScreenUtil.getInstance().setWidth(750),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                setState(() {
                  if(type!=JHSType.ju){
                    pager=1;
                    type = JHSType.ju;
                    beans.clear();
                    _getJHSGoods(pager.toString(),type,cid);
                  }

                });

              },
              child: Container(
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                decoration: BoxDecoration(
                  border: Border(top: type==JHSType.ju?redBorderSide:borderSide,
                      left: type==JHSType.ju?redBorderSide:borderSide,
                      right: type==JHSType.ju?redBorderSide:borderSide,
                      bottom: type==JHSType.ju?redBorderSide:borderSide),
                ),
                height: ScreenUtil.getInstance().setHeight(80),
                alignment: Alignment.center,
                child: Text(
                  '聚划算',
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                setState(() {
                  if(type!=JHSType.tqg){
                    beans.clear();
                    pager=1;
                    type = JHSType.tqg;
                    _getJHSGoods(pager.toString(),type,cid);
                  }

                });


              },
              child: Container(
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                decoration: BoxDecoration(
                  border: Border(top: type==JHSType.tqg?redBorderSide:borderSide,
                      left: type==JHSType.tqg?redBorderSide:borderSide,
                      right: type==JHSType.tqg?redBorderSide:borderSide,
                      bottom: type==JHSType.tqg?redBorderSide:borderSide),
                ),
                height: ScreenUtil.getInstance().setHeight(80),
                alignment: Alignment.center,
                child: Text(
                  '淘优购',
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20)),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: (){
                 setState(() {
                   if(type!=JHSType.hot){
                     beans.clear();
                     pager=1;
                     type = JHSType.hot;
                     _getJHSGoods(pager.toString(),type,cid);
                   }
                 });
              },
              child: Container(
                margin: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                decoration: BoxDecoration(
                  border: Border(top: type==JHSType.hot?redBorderSide:borderSide,
                      left: type==JHSType.hot?redBorderSide:borderSide,
                      right: type==JHSType.hot?redBorderSide:borderSide,
                      bottom: type==JHSType.hot?redBorderSide:borderSide),
                ),
                height: ScreenUtil.getInstance().setHeight(80),
                alignment: Alignment.center,
                child: Text(
                  '人气榜',
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(20)),
                ),
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
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            left: 0,
            child: GestureDetector(
              child: Icon(
                Icons.navigate_before,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: Text(
              '聚划算',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _getTabs() {
    getTagBarList().then((value) {
      var jsonstr = json.decode(value.toString());
      tabBar_Bean = new TabBar_Bean.fromJson(jsonstr);
      if (tabBar_Bean.classlist != null && tabBar_Bean.classlist.length > 0) {

        setState(() {
          cid = tabBar_Bean.classlist[0].id.toString();
          tabBar_Bean.classlist[0].setColor(Colors.grey);
          istabloading = false;
        });
        _getJHSGoods(pager.toString(),type,cid);
        print(tabBar_Bean.classlist[0].className);

      }
    });
  }



  Widget get tabbar{
    if(!istabloading){
      List<Widget> listWidget = [];
      if(tabBar_Bean.classlist.length>0){

        tabBar_Bean.classlist.forEach((item){
          listWidget.add(InkWell(
            onTap: (){
             setState(() {
               if(cid!=item.id.toString()){
                 cid = item.id.toString();
                 tabBar_Bean.classlist.forEach((item){
                   item.setColor(Colors.white);
                 });
                 item.setColor(Colors.grey);
                 beans.clear();
                 pager=1;
                 _getJHSGoods(pager.toString(),type,cid);
               }


             });
            },
            child: Container(
              alignment: Alignment.center,
              color:item.color,
              //width: ScreenUtil.getInstance().setWidth(100),
              //height:ScreenUtil.getInstance().setWidth(40) ,
              margin: EdgeInsets.all(1),
                padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(50),right: ScreenUtil.getInstance().setWidth(50),top: 0,bottom: 0),
              child: Text(item.className),

            ),
          ));
        });
      }

//      return ListView(
//        physics: ScrollPhysics(),
//        scrollDirection: Axis.horizontal,
//        children:listWidget,
//      );

      return Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil.getInstance().setWidth(10),ScreenUtil.getInstance().setWidth(10),ScreenUtil.getInstance().setWidth(10),0),
        color: Colors.white,
        width: ScreenUtil.getInstance().setWidth(750),
        height:ScreenUtil.getInstance().setWidth(60) ,
        child: ListView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children:listWidget,
        ),
      );



    }else{
      return Text('');
    }

  }







  Widget _wrapList() {
    if (beans?.length > 0) {
      List<Widget> listWidget = [];
      beans?.forEach((item) {
        listWidget.add(InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              Data data = new Data(
                id: item.id,
                bussName: item.bussName,
                taobaoId: item.taobaoId,
                pic: item.pic,
                couponLink: item.couponLink,
                shoujia: item.shoujia,
                juanhou: item.juanhou,
                quanFee: item.quanFee,
                sales: item.sales,
                commissionRate: item.commissionRate,
              );

              return GoodsDetail(
                data: data,
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
      return Center(
        child: Text('加载中'),
      );


    }
  }

}
