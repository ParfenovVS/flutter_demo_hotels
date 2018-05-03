import 'package:flutter/material.dart';
import 'package:flutter_demo/view/hotel_list.dart';
import 'common/strings.dart';

main() {
  runApp(
    new MaterialApp(
      title: Strings.appName,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new HotelsPage(),
    ),
  );
}