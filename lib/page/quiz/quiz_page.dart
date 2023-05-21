import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:face_guessing/page/quiz/component/face.dart';
import 'package:face_guessing/page/quiz/component/quiz_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_left_button.dart';
import 'package:face_guessing/page/quiz/component/transformed_right_button.dart';
import 'package:face_guessing/page/ranking/ranking_page.dart';
import 'package:face_guessing/page/register/component/register_page.dart';
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
  int ramdomindex = 0;

  @override
  void initState() {
    ramdomindex = Random().nextInt(4);
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
    final userlist = ref.watch(userEntitiesProvider);
    final score1 = userlist[0].score;
    final score3 = userlist[2].score;
    final user1 = userlist[0].name;
    final user2 = userlist[1].name;
    final user3 = userlist[2].name;
    final user4 = userlist[3].name;
    final currentimage = userlist[ramdomindex].imageValue;

    return Scaffold(
      body: SizedBox(
        width: _deviceWidth,
        height: _deviceHeight,
        child: Stack(
          children: [
           Center(
               child: Face(image: currentimage,)
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
                             return Dialog(player: user1, rotate: pi, index: ramdomindex,);
                           });
                       },
                     score: score1,
                     color: Colors.deepOrangeAccent,
                     name: user1,
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
                          return Dialog(player: user3, rotate: 0, index: ramdomindex,);
                        });
                    },
                  score: score3,
                  color: Colors.lightBlueAccent,
                  name: user3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 400,
                width: 140,
                child: QuizButtonLeft(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: user2, rotate: pi / 2, index: ramdomindex,);
                        });
                    },
                )
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 400,
                width: 134,
                child: QuizButtonRight(
                  time_counter: time_counter,
                  onPressed: () async{
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(player: user4, rotate: 3 * pi / 2, index: ramdomindex,);
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

class Dialog extends ConsumerWidget {
  final String player;
  final double rotate;
  final int index;
  const Dialog({Key? key, required this.player, required this.rotate, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userlist = ref.watch(userEntitiesProvider);
    String choice1 = userlist[0].name;
    String choice2 = userlist[1].name;
    String choice3 = userlist[2].name;
    String choice4 = userlist[3].name;
    String correct = userlist[index].name;
    return Transform.rotate(
      angle: rotate,
      child: SimpleDialog(
        title: Text("$playerの回答"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          SimpleDialogOption(
            child: Text(choice1),
            onPressed: (){
              if(choice1 == correct){
                ref.read(userEntitiesProvider.notifier).addScore(player);
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Congratulation!", index: index, rotate: rotate,);
                    });
              }else{
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Miss...", index: index, rotate: rotate,);
                    });
              }
            },
          ),
          SimpleDialogOption(
            child: Text(choice2),
            onPressed: (){
              if(choice2 == correct){
                ref.read(userEntitiesProvider.notifier).addScore(player);
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Congratulation!", index: index, rotate: rotate,);
                    });
              }else{
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Miss...", index: index, rotate: rotate,);
                    });
              }
            },
          ),
          SimpleDialogOption(
            child: Text(choice3),
            onPressed: (){
              if(choice3 == correct){
                ref.read(userEntitiesProvider.notifier).addScore(player);
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Congratulation!", index: index, rotate: rotate,);
                    });
              }else{
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Miss...", index: index, rotate: rotate,);
                    });
              }
            },
          ),
          SimpleDialogOption(
            child: Text(choice4),
            onPressed: (){
              if(choice4 == correct){
                ref.read(userEntitiesProvider.notifier).addScore(player);
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Congratulation!", index: index, rotate: rotate,);
                    });
              }else{
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) {
                      return popupanswer(title: "Miss...", index: index, rotate: rotate,);
                    });
              }
            },
          ),
        ],
      ),
    );
  }
}

class popupanswer extends ConsumerWidget {
  final String title;
  final int index;
  final double rotate;

  const popupanswer({Key? key, required this.title, required this.index, required this.rotate}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Uint8List image = ref.watch(userEntitiesProvider)[index].imageValue;
    final String correct = ref.watch(userEntitiesProvider)[index].name;
    return Transform.rotate(
      angle: rotate,
      child: AlertDialog(
        title: Text(title),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.memory(image),
            Text(correct,
            style: TextStyle(
              fontSize: 30,
            ),
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            child: OutlinedButton(
              child: const Text('Continue'),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const QuizPage())
                );
              },
            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => const QuizPage())
                  );
            },
          ),
          GestureDetector(
            child: OutlinedButton(
              child: const Text('End'),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => const RankingPage())
                );
              },
            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => const RegisterPage())
              );
            },
          )
        ],
      ),
    );
  }
}

