import 'package:flutter/material.dart';



class FirstPageScreen extends StatelessWidget {
  const FirstPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Container(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('game_page');
          },
          child: Text(
            'Start Game!',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )),
    ));
  }
}
