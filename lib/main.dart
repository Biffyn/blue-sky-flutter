import 'package:flutter/material.dart';

import 'home.page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: new HomePage(), 
    );
  }
}

