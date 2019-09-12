import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/bean/pdd_category_bean.dart';
import 'package:shopping/bean/shanpinbean.dart';
import 'package:shopping/pagers/goodsdetail.dart';
import 'package:shopping/service/service_method.dart';
import 'package:shopping/view/loading_dialog.dart';
import 'package:transparent_image/transparent_image.dart';


class PDDCategoryPager extends StatefulWidget {
  final int cid;

  const PDDCategoryPager({Key key, this.cid,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PDDCategoryPagerState(cid: cid);
  }
}

class PDDCategoryPagerState extends State<PDDCategoryPager> with AutomaticKeepAliveClientMixin{
  final int cid;
  var page = 1;
  EasyRefreshController _controller;
  List<GoodsList> shanPinList = [];
  var _count = 0;
  PDDCategoryBean bean ;
  PDDCategoryPagerState({Key key, this.cid});

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
          await getPDDCategroy(widget.cid.toString(),page.toString()).then((data){
            var jsonstr = json.decode(data.toString());
            bean = PDDCategoryBean.fromJson(jsonstr);
            if (mounted) {
              setState(() {
                page++;
                shanPinList.addAll(bean.goodsSearchResponse.goodsList);
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
    getPDDCategroy(widget.cid.toString(),page.toString()).then((data){
      var jsonstr = json.decode(data.toString());
      bean = PDDCategoryBean.fromJson(jsonstr);
      if (mounted) {
        setState(() {
          page++;
          shanPinList.addAll(bean.goodsSearchResponse.goodsList);
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
//            Data data =  new Data();
//
//            Navigator.push(context, MaterialPageRoute(builder: (context) {
//              return GoodsDetail(
//                data: item,
//                juanjia: (double.parse(item.quanFee)),
//              );
//            }));

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
                    image: item.goodsThumbnailUrl,
                  ),
                ),
                Container(
                  width: ScreenUtil.getInstance().setWidth(352),
                  child: Text(
                    item.goodsName,
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
                            '券  ¥${item.couponDiscount}',
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
                            "销量${item.salesTip}",
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
                            text: "¥${item?.minNormalPrice-item?.couponDiscount}",
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