import 'package:flutter/material.dart';
import 'package:gametest/Pages/first_page.dart';
import 'package:gametest/Pages/game_page.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'first_page',
    title: 'Game Test',
    routes: {
      'first_page': (context) => FirstPageScreen(),
      'game_page': (context) => GamePageScreen(),
    },
  ));
}




