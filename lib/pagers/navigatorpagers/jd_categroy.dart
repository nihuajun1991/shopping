import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shancheng/bean/jd_pagerbean.dart';
import 'package:shancheng/bean/pdd_category_bean.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/pagers/goodsdetail.dart';
import 'package:shancheng/pagers/navigatorpagers/jd_detail_pager.dart';
import 'package:shancheng/pagers/navigatorpagers/pdd_detail_pager.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:transparent_image/transparent_image.dart';


class JDCategoryPager extends StatefulWidget {
  final String Categoryname;

  const JDCategoryPager({Key key, this.Categoryname,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JDCategoryPagerState(Categoryname: Categoryname);
  }
}

class JDCategoryPagerState extends State<JDCategoryPager> with AutomaticKeepAliveClientMixin{
  final String Categoryname;
  var page = 1;
  EasyRefreshController _controller;
  List<JDPagerData> shanPinList = [];
  var _count = 0;
  JDPagerbean bean ;
  JDCategoryPagerState({Key key, this.Categoryname});

  @override
  void initState() {
    super.initState();
    _getShanpinPage();
    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return shanPinList?.length>0? Scaffold(
      body: EasyRefresh.custom(
        //onLoad: _getShanpinPage,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              _wrapList(),
            ]),
          ),
        ],

        onLoad: () async {
          print('加载更多-----page:$page');
          await getJDPager(page,cname: widget.Categoryname).then((data){
            var jsonstr = json.decode(data.toString());
            bean = JDPagerbean.fromJson(jsonstr);
            if (mounted) {
              setState(() {
                page++;

                for(int i=0;i<bean.data.length;i++ ){
                  print(bean.data[i].discount);
                  if(int.parse(bean.data[i].discount)>0){
                    shanPinList.add(bean.data[i]);
                  }
                }

//                bean.data.forEach((item){
//                  print(item.discount);
//
//                });
                //shanPinList.addAll(bean.data);
              });
            }

          }
          );
        },
      ),
    ) : Center(
      child: LoadDialog(),
    );




  }

  void _getShanpinPage() {
    getJDPager(page,cname: widget.Categoryname).then((data){
      var jsonstr = json.decode(data.toString());
      bean = JDPagerbean.fromJson(jsonstr);
      if (mounted) {
        setState(() {
          page++;
          for(int i=0;i<bean.data.length;i++ ){
            print(bean.data[i].discount);
            if(bean.data[i].discount!="0"){
              shanPinList.add(bean.data[i]);
            }
          }
        });
      }

    });
  }



  Widget _wrapList() {
    if (shanPinList?.length > 0) {
      List<Widget> listWidget = [];
      shanPinList?.forEach((item) {
        listWidget.add(InkWell(
          onTap: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return JDDetailPager(
              data: item,

              );
            }));

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
                    image: item.picUrl,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(352),
                  child: Text(
                    item.skuName,
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
                            '券  ¥${item.discount}',
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
                            text: "¥${item?.wlPriceAfter}",
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
        child: LoadDialog(),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}