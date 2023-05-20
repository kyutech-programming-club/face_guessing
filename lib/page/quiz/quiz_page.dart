import 'dart:async';
import 'dart:math';

import 'package:face_guessing/page/quiz/component/face.dart';
import 'package:face_guessing/page/quiz/component/quiz_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_left_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_right_button.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
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
    final score1 = ref.watch(Player1Score);
    final score2 = ref.watch(Player2Score);
    final score3 = ref.watch(Player3Score);
    final score4 = ref.watch(Player4Score);

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
                   height: 140,
                   width: 400,
                   child: QuizButton(
                     time_counter: time_counter,
                     onPressed: () async{
                       final String? selectedText = await showDialog<String>(
                           context: context,
                           barrierDismissible: false,
                           builder: (_) {
                             return Dialog(player: "プレイヤー１", rotate: pi,);
                           });
                       },
                     score: score1,
                     color: Colors.deepOrangeAccent,
                   ),
                 ),
             ),
           ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 140,
                width: 400,
                child: QuizButton(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: 'プレイヤー３', rotate: 0,);
                        });
                    },
                  score: score3,
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 400,
                width: 120,
                child: QuizButtonLeft(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: 'プレイヤー２', rotate: pi / 2,);
                        });
                    },
                )
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 400,
                width: 109,
                child: QuizButtonRight(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: 'プレイヤー４', rotate: 3 * pi / 2,);
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
  final double rotate;
  const Dialog({Key? key, required this.player, required this.rotate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate,
      child: SimpleDialog(
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
      ),
    );
  }
}
