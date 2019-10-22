
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shancheng/bean/shanpinbean.dart';
import 'package:shancheng/bean/tbsearchbean.dart';
import 'package:shancheng/pagers/goodsdetail.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:transparent_image/transparent_image.dart';

class TbSearchResult extends StatefulWidget{
  final String searchstr;

  const TbSearchResult({Key key, this.searchstr}) : super(key: key);
  @override
  _TbSearchResultStates createState() {
    return _TbSearchResultStates();
  }

}

class _TbSearchResultStates extends State<TbSearchResult>{
   var debugstr="" ;
   int pager = 1;
   bool isload = false;
   List<TbSearchData> _TbSearchData=[];


  @override
  void initState() {
    super.initState();
    isload = true;
    _search(widget.searchstr);
  }

  _search(String searchstr){
    tbsearch(searchstr,pager).then((value){
      debugPrint("tbsearch"+value.toString());

      var jsonstr = json.decode(value.toString());
      var bean = TbSearchbean.fromJson(jsonstr);
      if(bean.proList.data!=null){
        _TbSearchData.addAll(bean.proList.data);
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

    if (_TbSearchData!=null&&_TbSearchData.length>0){
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
              itemCount: _TbSearchData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 7,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    print("点击了");
                    Data data = new Data(
                      id: int.parse(_TbSearchData[index].id),
                      bussName: _TbSearchData[index].bussName,
                      taobaoId: _TbSearchData[index].taobaoId,
                      pic: _TbSearchData[index].pic,
                      couponLink: _TbSearchData[index].couponLink,
                      shoujia: _TbSearchData[index].shoujia,
                      juanhou: _TbSearchData[index].juanhou,
                      quanFee: _TbSearchData[index].quanFee,
                      sales: _TbSearchData[index].sales,
                      commissionRate: _TbSearchData[index].commissionRate,
                    );
                    //print("data:" + data.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return GoodsDetail(
                        data: data,
                        juanjia: double.parse(data.quanFee),
                      );
                    }));
                  },
                  child: _item(_TbSearchData[index], index),
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


   Widget _item(TbSearchData item, int index) {
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
                       "销量${item.sales}",
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
                       text: "¥${item.juanhou}",
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

}
