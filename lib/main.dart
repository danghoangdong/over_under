import 'package:flutter/material.dart';
import 'package:over_under/Login.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login', debugShowCheckedModeBanner: false, home: Login());
  }
}
