import 'dart:math';

import 'package:face_guessing/page/quiz/component/face.dart';
import 'package:face_guessing/page/quiz/component/quiz_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_left_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_right_button.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        width: _deviceWidth,
        height: _deviceHeight,
        child: Stack(
          children: [
           Center(
               child: Face()
           ) ,
           Align(
             alignment: Alignment.topCenter,
             child: Transform.rotate(
                 angle: pi,
                 child: Container(
                   height: 100,
                   width: 400,
                   color: Colors.red,
                   child: QuizButton(),
                 ),
             ),
           ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: 400,
                color: Colors.blue,
                child: QuizButton(),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 400,
                width: 100,
                color: Colors.green,
                child: QuizButtonLeft()
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 400,
                width: 100,
                color: Colors.yellow,
                child: QuizButtonRight()
              ),
            )
          ],
        ),
      ),
    );
  }
}
