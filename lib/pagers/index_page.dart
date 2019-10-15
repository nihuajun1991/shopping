import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shancheng/pagers/cart_page.dart';
import 'package:shancheng/pagers/category_page.dart';
import 'package:shancheng/pagers/home_page.dart';
import 'package:shancheng/pagers/member_page.dart';

import 'goods_pager.dart';

class IndexPage extends StatefulWidget{
 


  @override
  State<StatefulWidget> createState() {

    return new _IndexPagerState();
  }

}

class _IndexPagerState extends State<IndexPage>{
  

    final List<BottomNavigationBarItem> buttonTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),title:Text("首页")),
    // BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),title:Text("分类")),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),title:Text("购物车")),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),title:Text("会员中心"))
  ];

  final List<Widget> tabBodies = [GoodsPager(),CartPage(),MemberPage()];
  int currentIndex  = 0;
  var currentPage ;

  @override
  void initState() {
    //currentPage = tabBodies[currentIndex];
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
      ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: buttonTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            //currentPage = tabBodies[currentIndex];
          });
        },
      ),
      body: IndexedStack(
       index: currentIndex,
       children: tabBodies,
      )
      
    );
  }
    
  }