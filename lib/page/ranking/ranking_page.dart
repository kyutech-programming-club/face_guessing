import 'dart:typed_data';

import 'package:face_guessing/page/camera/camera_page.dart';
import 'package:face_guessing/page/register/component/register_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RankingPage extends ConsumerWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    final _deviceHeight = MediaQuery.of(context).size.height;
    final userlist = ref.watch(userEntitiesProvider);
    userlist.sort((a,b) => -a.score.compareTo(b.score));
    return Scaffold(
      appBar: AppBar(
        title: Text('ランキング'),
      ),
      body: SizedBox(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('1位  ${userlist[0].name} ${userlist[0].score}pt',
                   style: TextStyle(
                   fontSize: 60),
              ),
                  Text('2位  ${userlist[1].name} ${userlist[1].score}pt',
                    style: TextStyle(
                    fontSize: 60),
                  ),
                  Text('3位  ${userlist[2].name} ${userlist[2].score}pt',
                    style: TextStyle(
                    fontSize: 60),
                  ),
                  Text('4位  ${userlist[3].name} ${userlist[3].score}pt',
                    style: TextStyle(
                    fontSize: 60),
                  ),
                ]
                ),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                child: const Text('Exit',
                style: TextStyle(
                  fontSize: 20,
                ),),
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(),
                ),
                onPressed: () {
                  ref.read(userEntitiesProvider.notifier).ClearUserentity();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) => const RegisterPage())
                  );
                },
              ),
            ),
          ],
        ),
      ),
      );
  }
}
