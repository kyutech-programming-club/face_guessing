import 'dart:async';
import 'dart:math';

import 'package:face_guessing/page/quiz/component/face.dart';
import 'package:face_guessing/page/quiz/component/quiz_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_left_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_right_button.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  double time_counter = 30;

  @override
  void initState() {
    super.initState();
    // 1. Timer.periodic : 新しい繰り返しタイマーを作成します
    // 1秒ごとに _counterを1ずつ足していく
    Timer.periodic(
      // 第一引数：繰り返す間隔の時間を設定
      const Duration(seconds: 1),
      // 第二引数：その間隔ごとに動作させたい処理を書く
          (Timer timer) {
        time_counter--;
        setState(() {});
      },
    );
  }
  
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
                   child: QuizButton(
                     time_counter: time_counter,
                     onPressed: () async{
                       final String? selectedText = await showDialog<String>(
                           context: context,
                           barrierDismissible: false,
                           builder: (_) {
                             return Dialog(player: "プレイヤー１",);
                           });
                     },
                   ),
                 ),
             ),
           ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: 400,
                color: Colors.blue,
                child: QuizButton(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: 'プレイヤー３',);
                        });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 400,
                width: 100,
                color: Colors.green,
                child: QuizButtonLeft(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: 'プレイヤー２',);
                        });
                  },
                )
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 400,
                width: 100,
                color: Colors.yellow,
                child: QuizButtonRight(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: 'プレイヤー４',);
                        });
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Dialog extends StatelessWidget {
  final String player;
  const Dialog({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("$playerの回答"),
      children: [
        SimpleDialogOption(
          child: Text("選択肢1"),
        ),
        SimpleDialogOption(
          child: Text("選択肢2"),
        ),
        SimpleDialogOption(
          child: Text("選択肢3"),
        ),
        SimpleDialogOption(
          child: Text("選択肢4"),
        ),
      ],
    );
  }
}
