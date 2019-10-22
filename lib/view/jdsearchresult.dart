
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shancheng/bean/jd_pagerbean.dart';
import 'package:shancheng/bean/jdsearchbean.dart';
import 'package:shancheng/bean/pddsearchbean.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/bean/tbsearchbean.dart';
import 'package:shancheng/pagers/goodsdetail.dart';
import 'package:shancheng/pagers/navigatorpagers/jd_detail_pager.dart';
import 'package:shancheng/pagers/navigatorpagers/pdd_detail_pager.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:transparent_image/transparent_image.dart';

class JdSearchResult extends StatefulWidget{
  final String searchstr;

  const JdSearchResult({Key key, this.searchstr}) : super(key: key);
  @override
  _JdSearchResultStates createState() {
    return _JdSearchResultStates();
  }

}

class _JdSearchResultStates extends State<JdSearchResult> with AutomaticKeepAliveClientMixin{
   var debugstr="" ;
   int pager = 1;
   bool isload = false;
   List<JDSearchData> _JDSearchData=[];


  @override
  void initState() {
    super.initState();
    isload = true;
    _search(widget.searchstr);
  }

  _search(String searchstr){
    getJDGoodsSearch(searchstr).then((value){
      debugPrint("JDSearch"+value.toString());

        var jsonstr = json.decode(value.toString());
      var bean = JDSearchbean.fromJson(jsonstr);
      if(bean.data!=null){
        _JDSearchData.addAll(bean.data);
        pager++;
      }
      setState(() {
        isload = false;

      });
    });
  }


  @override
  Widget build(BuildContext context) {


    if(isload){
      return LoadDialog();
    }else{
      return Container(
          color: Color(int.parse("0xffffffff")),
//        padding:
//        EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
          child: Column(
            children: <Widget>[
              _ShanPinList()],
          ));
    }


  }



   Widget _ShanPinList() {

    if (_JDSearchData!=null&&_JDSearchData.length>0){
      return  Expanded(
        child: Container(
          color: Color(int.parse("0xffeeeeee")),
          child: EasyRefresh(
            header: BallPulseHeader(),
            footer: BallPulseFooter(),
            onLoad: () async {
              _search(widget.searchstr);
            },
            child: GridView.builder(
              padding: EdgeInsets.only(top: 0),
              itemCount: _JDSearchData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 7,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    print("点击了");
                    JDPagerData data = new JDPagerData();
                    data.skuId =_JDSearchData[index].skuId;
                    data.discount = (_JDSearchData[index].couponInfo.couponList.length>0?_JDSearchData[index].couponInfo.couponList[0].discount:0).toString();
                    //data.couponList = _JDSearchData[index].couponInfo.couponList;
                    data.wlPriceAfter = ((double.parse(_JDSearchData[index]?.priceInfo.price))
                        - (_JDSearchData[index].couponInfo.couponList.length>0?double.parse(_JDSearchData[index].couponInfo.couponList[0].discount):0)).toStringAsFixed(2);
                    data.wlPrice = _JDSearchData[index].priceInfo.price;
                    data.skuName =  _JDSearchData[index].skuName;



                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return JDDetailPager(
                        data: data,

                      );
                    }));


                  },
                  child: _item(_JDSearchData[index], index)
                );

              },
            ),


          ),
        ),


      );
    }else{
      return Container(
        child: Center(
          child: Text('没有商品'),
        ),
      );
    }


   }


   Widget _item(JDSearchData item, int index) {
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
               image: item.imageInfo.imageList[0].url??'',
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
                         color: item.couponInfo.couponList.length>0?Colors.red:Colors.grey,
                         boxShadow: [
                           new BoxShadow(
                             color: item.couponInfo.couponList.length>0?Colors.red:Colors.grey, //阴影颜色
                             blurRadius: 2.0, //阴影大小
                           ),
                         ],
                         border: Border.all(color: item.couponInfo.couponList.length>0?Colors.red:Colors.grey, width: 1.0),
                         borderRadius: BorderRadius.circular(3.0)),
                     padding: EdgeInsets.all(3.0),
                     margin: EdgeInsets.only(top: 5.0),
                     //color: Colors.red,
                     child: Text(
                       '券  ¥${item.couponInfo.couponList.length>0?item.couponInfo.couponList[0].discount:0}',
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
                       "销量${item.inOrderCount30Days}",
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
                       text: "¥${((double.parse(item?.priceInfo.price))
                           - (item.couponInfo.couponList.length>0?double.parse(item.couponInfo.couponList[0].discount):0)).toStringAsFixed(2)}",
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

  @override
  bool get wantKeepAlive => true;

}
