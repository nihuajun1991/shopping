import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/bean/shanpinbean.dart';
import 'package:shopping/pagers/goodsdetail.dart';
import 'package:shopping/service/service_method.dart';
import 'package:shopping/view/loading_dialog.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryPage extends StatefulWidget {
  final int cid;

  const CategoryPage({Key key, this.cid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryPageState(cid: cid);
  }
}

class CategoryPageState extends State<CategoryPage> {
  final int cid;
  var page = 1;
  List<Data> shanPinList = [];
  EasyRefreshController _controller;
  var _count = 0;
  CategoryPageState({Key key, this.cid});

  @override
  void initState() {
    super.initState();
     _getShanpinPage();
    _controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    // return EasyRefresh.custom(
    //   enableControlFinishRefresh: false,
    //   enableControlFinishLoad: true,
    //   controller: _controller,
    //   header: BallPulseHeader(),
    //   footer: BallPulseFooter(),
    //   onRefresh: () async {
    //     page=0;
    //     await getShanPinList(pager: page, cid: cid).then((value) {
    //       var beanstr = json.decode(value.toString());
    //       var bean = new ShanpinBean.fromJson(beanstr);
    //       List<Data> newShanpinList = bean.proList.data;
    //       setState(() {
    //         shanPinList.addAll(newShanpinList);
    //         page++;
    //       });
    //     });
    //   },

    //   onLoad: () async {
    //     await getShanPinList(pager: page, cid: cid).then((value) {
    //       var beanstr = json.decode(value.toString());
    //       var bean = new ShanpinBean.fromJson(beanstr);
    //       List<Data> newShanpinList = bean.proList.data;
    //       setState(() {
    //         shanPinList.addAll(newShanpinList);
    //         page++;
    //       });
    //     });
    //   },
    //    slivers: <Widget>[
    //     SliverGrid(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //             crossAxisCount: 2, //Grid按两列显示
    //             mainAxisSpacing: 1.0,
    //             crossAxisSpacing: 1.0,
    //             childAspectRatio: 0.75, 
              
    //       ),
    //       delegate: new SliverChildBuilderDelegate(
    //                 (BuildContext context, int index) {
    //               //创建子widget      
    //               return _BuildItem(shanPinList[index]);
    //             },
    //             childCount: shanPinList.length
    //       ),
    //     )
    //    ],
    // );

  


    return EasyRefresh(
      child: _wrapList(),
      onLoad: () async{
          print('加载更多');
          await getShanPinList(pager:page,cid: cid).then((value) {
            var beanstr = json.decode(value.toString());
            var bean = new ShanpinBean.fromJson(beanstr);
            List<Data> newShanpinList = bean.proList.data;
            setState(() {
              shanPinList.addAll(newShanpinList);
              page++;
            });
          });
      },
      header: BallPulseHeader(),
      footer: BallPulseFooter(),
    );
  }

  void _getShanpinPage() {
    getShanPinList(pager: page, cid: cid).then((value) {
      var beanstr = json.decode(value.toString());
      var bean = new ShanpinBean.fromJson(beanstr);
      List<Data> newShanpinList = bean.proList.data;
      setState(() {
        shanPinList.addAll(newShanpinList);
        page++;
      });
    });
  }

   void _getTbProductInfo(tbId) {
    getTbProductInfo(tbId).then((value) {
      var Info = json.decode(value.toString());
      print("Info:$Info");
    
    });
  }


   Widget _BuildItem(item){

     return InkWell(
          onTap: () {
             
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(300),
                  color: Colors.white,
                  child: new FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item.pic,
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(372),
                  child: Text(
                    item.bussName,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(22)),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: ScreenUtil().setWidth(100),
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
                                fontSize: ScreenUtil().setSp(22)),
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
                                fontSize: ScreenUtil().setSp(22)),
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
                                fontSize: ScreenUtil().setSp(22))),
                        TextSpan(
                            text: "  券后",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: ScreenUtil().setSp(18)))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
   }




  Widget _wrapList() {
    if (shanPinList.length > 0) {
      List<Widget> listWidget = [];
      shanPinList.forEach((item) {
        listWidget.add(InkWell(
          onTap: () {
             Navigator.push(context,
             MaterialPageRoute(builder: (context){
               return GoodsDetail(data:item,juanjia: (double.parse(item.quanFee) ),);
             })  
             );
          
            //_getTbProductInfo(item.taobaoId);
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setHeight(300),
                  color: Colors.white,
                  child: new FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item.pic,
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(372),
                  child: Text(
                    item.bussName,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(22)),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: ScreenUtil().setWidth(100),
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
                                fontSize: ScreenUtil().setSp(22)),
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
                                fontSize: ScreenUtil().setSp(22)),
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
                                fontSize: ScreenUtil().setSp(22))),
                        TextSpan(
                            text: "  券后",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: ScreenUtil().setSp(18)))
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        );
      });

      // return SliverGrid.count(
      //   crossAxisCount: 2,
      //   children: listWidget,
      // );

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text("");
    }
  }
}
