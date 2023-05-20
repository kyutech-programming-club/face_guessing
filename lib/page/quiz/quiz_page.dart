import 'package:face_guessing/page/quiz/component/face.dart';
import 'package:face_guessing/page/quiz/component/quiz_button.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            color: Colors.black,
            height: 100,
            width: 200,
          ),
          QuizButton(),
          Face()
        ],
      ),
    );
  }
}
