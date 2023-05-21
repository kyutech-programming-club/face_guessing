import 'dart:typed_data';

import 'package:face_guessing/page/camera/camera_page.dart';
import 'package:face_guessing/page/register/component/register_page.dart';
import 'package:flutter/material.dart';
import 'confirm_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() => runApp(ConfirmPage());

class ConfirmPage extends ConsumerWidget {
  const ConfirmPage({super.key});

  get ref => null;


  //画面に描画するデータリスト作成


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final texts = ref.watch(userEntitiesProvider);
    final images = ref.watch(userEntitiesProvider);
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(title: Text('確認画面'),
        ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 上のFAB
              Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraPage(),
                      ),
                    );
                  },
                label: Text("撮影"),
                ),

              ),

              // 下のFAB
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    );
                  },
                label: Text("完了"),
                ),
              ),
            ],
          ),
        body: GridView.builder(
          padding: const EdgeInsets.all(20), //4辺すべて同じ値の余白
          itemCount: texts.length, //要素の数　表示するデータ数の最大値（texts　listの最大値）
          // GridViewを設定する引数を指定
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisSpacing: 10,     //ボックス左右間のスペース
            mainAxisSpacing: 10,      //ボックス上下間のスペース
            crossAxisCount: 2,        //ボックスを横に並べる数
          ),
          //指定した要素の数分を生成
          itemBuilder: (context, index) {
            final image = texts[index].imageValue;
            return SizedBox(
              height: 100,
              child: Column(
                children: [
                  Image.memory(image),
                  Text(texts[index].name,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}