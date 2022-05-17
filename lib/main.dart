// ignore_for_file: unused_import

import 'package:mobilehairdresser_app/screens/home_page.dart';
import 'package:mobilehairdresser_app/screens/login_page.dart';
import 'package:mobilehairdresser_app/screens/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      home: const Loading(),
      
    );
  }
}
