import 'package:flutter/material.dart';
import 'package:patterns_scoped/pages/create_page.dart';
import 'package:patterns_scoped/pages/home_page.dart';
import 'package:patterns_scoped/pages/update_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        CreatePage.id: (context) => CreatePage(),
        HomePage.id: (context) => HomePage(),
        UpdatePage.id:(context) => UpdatePage(),
      },
    );
  }
}

