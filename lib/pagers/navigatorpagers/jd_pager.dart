import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shancheng/pagers/navigatorpagers/jd_categroy.dart';
import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/loading_dialog.dart';
import 'package:shancheng/view/myappbar.dart';


class JdPager extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _JDPagerState();
  }
}


class _JDPagerState extends State with SingleTickerProviderStateMixin{
  TabController controller; //tab控制器
  List<Widget> tabs = [];
  bool tabloading = false;
  int _currentIndex = 0; //选中下标
  List<dynamic>  list;

     @override
  void initState() {
       _getJDTab();
    super.initState();
  }


  _getJDTab() {
    getJDcategory().then((value) {
      var jsonstr = json.decode(value.toString());
      print(jsonstr.toString());
      if(jsonstr['data']!=null){
        list= jsonstr['data'];
        for( int i =0;i<list.length;i++){
          tabs.add(new Tab(
            text: list[i].toString(),
          ));
        }
      }


     // tabs = jsonstr['data'];

      setState(() {
        controller = TabController(length: tabs.length, vsync: this);
        controller.addListener(() => _onTabChanged());
        tabloading = false;

      });
    });
  }

  _onTabChanged() {
    if (controller.indexIsChanging) {
      if (this.mounted) {
        //赋值 并更新数据
        this.setState(() {
          _currentIndex = controller.index;
        });
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    if (!tabloading&&tabs.length > 0) {
      return Scaffold(
        appBar: MAppBar(
          child: _Title(),
        ),
        body: _isLoadOk(),
      );

    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body:LoadDialog(text: "加载中"),
      );


    }
  }

  Widget _isLoadOk() {
    if (tabs.length > 0) {
      //print("_isLoadOk${tabs.length}");
      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TabBar(
            controller: controller,
            labelColor: Colors.pink,
            indicatorColor: Colors.pink,
            labelStyle: TextStyle(fontSize: ScreenUtil().setSp(22)),
            isScrollable: true,
            tabs: tabs,
            onTap: (int i) {
              // print(i);
            },
          ),
          body: new TabBarView(
            controller: controller,
            children: !tabloading?_getPager():Center(child: Text('加载中'),),
          ),
        ),
      );

    }
//    else {
//      return Scaffold(
//        backgroundColor: Colors.white,
//        body: LoadDialog(text:"加载中"),
//      );
//
//
//    }
  }

  List<Widget> _getPager() {
    List<Widget> pagers = [];

    for (int i = 0; i < tabs.length; i++) {
      pagers.add(JDCategoryPager(Categoryname:list[i].toString()));
    }
    return pagers;
  }



  Widget _Title() {
    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().setHeight(60),
      width: ScreenUtil.getInstance().setWidth(750),
      child:Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[


          Positioned(

            left: 0,
            child:GestureDetector(
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
              '京东',
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

}



