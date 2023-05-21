import 'dart:typed_data';

import 'package:face_guessing/entity/user_entity.dart';
import 'package:face_guessing/page/camera/camera_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ranking/ranking_page.dart';
import 'confirm_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
            ElevatedButton(
              child: Text('スタート',
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
            ), ElevatedButton(
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
    );
  }
}
