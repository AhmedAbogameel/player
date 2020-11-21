import 'package:flutter/material.dart';
import 'package:quraan_player/views/home/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Quran Player',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          platform: TargetPlatform.iOS,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeView(),
      );
  }
}