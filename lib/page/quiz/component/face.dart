import 'dart:async';
import 'dart:typed_data';

import 'package:face_guessing/page/quiz/component/mask_widget.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class Face extends StatefulWidget {
  final Uint8List image;
  const Face({Key? key, required this.image}) : super(key: key);

  @override
  State<Face> createState() => _FaceState();
}

class _FaceState extends State<Face> {

  // カウンター
  double top_counter = 0;
  double left_counter = 0;

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
        top_counter++;
        left_counter++;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: MaskWidget(
          top: top_counter,
          left: left_counter,
          blendMode : BlendMode. srcATop,
          childSaveLayer: true,
          mask: Image.memory(
            widget.image,
            height: 300,
            width: 300,
          ),
          child: Center(
            child: Container(
              color: Colors.white,
              height: 100,
              width: 100,
            ),
          )
      ),
    );
  }
}
