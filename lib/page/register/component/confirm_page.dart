import 'package:face_guessing/page/camera/camera_page.dart';
import 'package:face_guessing/page/register/component/register_page.dart';
import 'package:flutter/material.dart';
import 'confirm_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() => runApp(ConfirmPage());

class ConfirmPage extends StatelessWidget {

  //画面に描画するデータリスト作成
  final List<String> texts = [
    '1', '2', '3', '4',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(title: Text('Gridview デモ'),
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
            return Container(
              color: Colors.blue.shade100,
              child: Center(
                  child: Text(texts[index],
                style: TextStyle(fontSize: 50,),
              )),
            );
          },
        ),
      ),
    );
  }
}