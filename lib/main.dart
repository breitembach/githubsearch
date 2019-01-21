import 'package:flutter/material.dart';
import 'package:programacaoreativa/home/HomeWidget.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride; // for desktop embedder

void main() {
  debugDefaultTargetPlatformOverride =
      TargetPlatform.fuchsia; // for desktop embedder
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeWidget(),
    );
  }
}
