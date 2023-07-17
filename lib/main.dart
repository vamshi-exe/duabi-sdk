import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
//import 'package:plugin_ccavenue/plugin_ccavenue.dart';
import 'package:dubai_sdk_kotlin/page/home_page.dart';

import 'style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CCAvenue',
      theme: ThemeData(
      primarySwatch: Colors.blue,
     
      visualDensity: VisualDensity.adaptivePlatformDensity,
       //buttonColor: AppColors.primary,
       dividerColor: Colors.transparent,
       brightness: Brightness.light
    ),
    themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home:const Home(),
    );
  }
}
