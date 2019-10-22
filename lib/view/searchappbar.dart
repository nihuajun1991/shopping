import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchAppBar({@required this.child}) : assert(child != null);
  final Widget child;
  @override
  Size get preferredSize {
    return new Size.fromHeight(ScreenUtil().setHeight(109));
  }
  @override
  State createState() {
    return new MAppBarState();
  }
}
class MAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      
      child:Container(
        //color: Colors.white,
        child: widget.child,

      )
    ,);
  }
}
