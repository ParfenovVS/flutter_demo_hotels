import 'package:flutter/material.dart';
import 'package:flutter_demo/view/hotel_list.dart';
import 'common/strings.dart';

main() {
  runApp(
    MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HotelsPage(),
    ),
  );
}