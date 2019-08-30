import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'pagers/index_page.dart';


void main(){
  runApp(MyApp());
  
 FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
     FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
} 

class MyApp extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: MaterialApp(
        title: '百姓生活',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
  

}





