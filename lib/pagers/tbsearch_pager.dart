

import 'package:flutter/material.dart';

class TbSearch extends StatefulWidget{

  @override
  TbSearchState createState() {
    return TbSearchState();
  }
}


class TbSearchState extends State<TbSearch>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('搜索'),
      ),
    );
  }

}