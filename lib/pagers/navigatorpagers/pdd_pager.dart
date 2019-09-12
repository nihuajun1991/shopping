import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopping/bean/pdd_bean.dart';
import 'package:shopping/pagers/navigatorpagers/pdd_categroy.dart';
import 'package:shopping/service/service_method.dart';
import 'package:shopping/view/loading_dialog.dart';
import 'package:shopping/view/myappbar.dart';


class PDDPager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PDDPagerState();
}

class _PDDPagerState extends State<PDDPager>
    with SingleTickerProviderStateMixin {
  String str = '';
  TabController controller; //tab控制器
  List<Widget> tabs = [];
  int _currentIndex = 0; //选中下标
  bool tabloading = false;
  PDDBean bean;
  @override
  void initState() {
    tabloading = true;
    _getPDDTab();

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

  _getPDDTab() {
    getPDDTab().then((value) {
      var jsonstr = json.decode(value.toString());
       bean = PDDBean.fromJson(jsonstr);
      
  
      if(bean.goodsOptGetResponse?.goodsOptList?.length>0){
      for( int i =0;i<bean.goodsOptGetResponse?.goodsOptList.length;i++){
        tabs.add(new Tab(
          text: bean.goodsOptGetResponse?.goodsOptList[i].optName,
        ));
      }
      }
      controller = TabController(length: tabs.length, vsync: this);
      controller.addListener(() => _onTabChanged());
      setState(() {
        tabloading = false;

      });
    });
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
      pagers.add(PDDCategoryPager(cid:bean.goodsOptGetResponse?.goodsOptList[i].optId));
    }
    return pagers;
  }


  Widget _Title() {
    return Container(
      color: Colors.white,
      height: ScreenUtil.getInstance().setHeight(60),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.navigate_before,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                '拼多多',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


}
