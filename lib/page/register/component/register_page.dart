import 'dart:typed_data';

import 'package:face_guessing/entity/user_entity.dart';
import 'package:face_guessing/page/camera/camera_page.dart';
import 'package:face_guessing/page/quiz/quiz_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ranking/ranking_page.dart';
import 'confirm_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final image = ref.watch(faceImageProvider);
    final inputname = "rech(faceImageProvider)";
    return Scaffold(
      floatingActionButton:FloatingActionButton(
          onPressed: ()
          { ref.read(userEntitiesProvider.notifier).addUserEntity(UserEntity(name:inputname , imageValue: image!, score: 0));
          }
      ),


      body: Center(
        child: SizedBox(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
            '顔あてゲーム'
                ''
                ' ',
            style: TextStyle(
              fontSize: 60,
              color: Colors.black,
            ),
          ),
              Text(
                ''
                    ''
                    ' ',
                style: TextStyle(
                  fontSize: 90,
                  color: Colors.black,
                ),
              ),

              ElevatedButton(
                child: Text('登録する',
                         style: TextStyle(
                         fontSize: 40),
                       ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPage(),
                    ),
                  );
                },
              ),
              Spacer(),
              ElevatedButton(
                child: Text('スタート',
                        style: TextStyle(
                        fontSize: 40),
                           ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(),
                    ),
                  );
                },
              ),
              Spacer(), ElevatedButton(
                child: Text('ランキング',
                        style: TextStyle(
                            fontSize: 40),
                            ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RankingPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
