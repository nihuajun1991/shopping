import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shancheng/view/pddsearchresult.dart';
import 'package:shancheng/view/tbsearchresult.dart';

typedef SearchItemCall = void Function(String item);

class PddSearchBarDelegate extends SearchDelegate<String>{

  //final String title;

  @override
  List<Widget> buildActions(BuildContext context) {
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //点击了搜索显示的页面
    return Center(
      child: PddSearchResult(searchstr: query,),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //点击了搜索框显示的页面，比如搜索历史等
    return SearchContentView();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }
}

class SearchContentView extends StatefulWidget {
  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:ScreenUtil.getInstance().setWidth(780),
      padding: EdgeInsets.all(10),
      color:Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Container(
//            child: Text(
//              '大家都在搜',
//              style: TextStyle(fontSize: 16),
//            ),
//          ),
//          SearchItemView(),
//          Container(
//            margin: EdgeInsets.only(top: 20),
//            child: Text(
//              '历史记录',
//              style: TextStyle(fontSize: 16),
//            ),
//          ),
//          SearchItemView()
        ],
      ),

    );
  }
}

class SearchItemView extends StatefulWidget {
  @override
  _SearchItemViewState createState() => _SearchItemViewState();
}

class _SearchItemViewState extends State<SearchItemView> with AutomaticKeepAliveClientMixin{
  List<String> items = [
    '面试',
    'Studio3',
    '动画dfsfds',
    '自定义View',
    '性能优化',
    'gradle',
    'Camera',
    '代码混淆 安全',
    '逆向加固'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        spacing: 10,
        // runSpacing: 0,
        children: items.map((item) {
          return SearchItem(title: item);
        }).toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchItem extends StatefulWidget {
  @required
  final String title;
  const SearchItem({Key key, this.title}) : super(key: key);
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Chip(
          label: Text(widget.title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        onTap: () {
          print(widget.title);
        },
      ),
      color: Colors.white,
    );
  }
}