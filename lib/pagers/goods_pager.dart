import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shancheng/bean/tabbar_bean.dart';
import 'package:shancheng/pagers/home_page.dart';

import 'package:shancheng/service/service_method.dart';
import 'package:shancheng/view/tbsearchwidget.dart';
import '../view/loading_dialog.dart';
import '../view/myappbar.dart';
import 'category_page.dart';

class GoodsPager extends StatefulWidget {
  @override
  _GoodsPagerState createState() => _GoodsPagerState();
}

class _GoodsPagerState extends State<GoodsPager>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TabController controller; //tab控制器
  int _currentIndex = 0; //选中下标

  var bean = new TabBar_Bean();

  //List<TabBar_Bean> _datas = new List(); //tab集合
  List<Widget> tabs = [];
  //List<ProjectListDataData> _listDatas = new List();//内容集合

  @override
  void initState() {
    _getTabs();
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
    // print("state:{$state}");
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        child: InkWell(
          onTap: () {
            print("点击搜索框");
            showSearch(context: context, delegate: SearchBarDelegate());
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black12,
                    //阴影颜色
                    blurRadius: 2.0, //阴影大小
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
                border: Border(
                    // top:BorderSide(width: 0.5, color: Colors.black) ,
                    // bottom: BorderSide(width: 0.5, color: Colors.black),
                    )),
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Icon(
              Icons.search,
              color: Colors.pink,
              size: ScreenUtil().setHeight(28),
            ),
          ),
        ),
      ),
      body: _isLoadOk(),
    );
  }

  Widget _isLoadOk() {
    if (tabs.length > 0) {
      //print("_isLoadOk${tabs.length}");
      return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
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
            children: _getPager(),
          ),
        ),
      );
    } else {
      return LoadDialog(text: "加载中");
    }
  }

  List<Widget> _getPager() {
    List<Widget> pagers = [];

    for (int i = 0; i < tabs.length; i++) {
      if (i == 0) {
        pagers.add(HomePage());
      } else {
        if (bean.isLike != null) {
          pagers.add(CategoryPage(cid: (i - 1)));
        } else {
          pagers.add(CategoryPage(cid: (i)));
        }
      }
    }
    return pagers;
  }

  void _getTabs() {
    getTagBarList().then((value) {
      var jsonstr = json.decode(value.toString());
      bean = new TabBar_Bean.fromJson(jsonstr);

      if (bean.classlist != null && bean.classlist.length > 0) {
        if (tabs.length == 0) {
          tabs.add(new Tab(
            text: '推荐',
          ));
        }

        if (bean.isLike != null) {
          tabs.add(new Tab(
            child: Image.network(
              bean.isLike.imgUrl,
              width: ScreenUtil().setWidth(150),
            ),
          ));
        }

        bean.classlist.forEach((item) {
          tabs.add(new Tab(
            text: item.className,
          ));
        });
        setState(() {
          _currentIndex = 0;
          //print("setState${tabs.length}");
        });

        controller = TabController(length: tabs.length, vsync: this);
        controller.addListener(() => _onTabChanged());
      }
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
}
