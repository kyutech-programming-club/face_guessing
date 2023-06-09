import 'dart:async';
import 'dart:math';
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
  double counter = 0;
  double top_counter = 0;
  double left_counter = 0;

  @override
  void initState() {
    super.initState();
    // 1. Timer.periodic : 新しい繰り返しタイマーを作成します
    // 1秒ごとに _counterを1ずつ足していく
    Timer.periodic(
      // 第一引数：繰り返す間隔の時間を設定
      const Duration(milliseconds: 100),
      // 第二引数：その間隔ごとに動作させたい処理を書く
          (Timer timer) {
        int R = 70;
        counter = counter + 0.001;
        top_counter = 3*R*sin(counter) - 2*R*sin(3/2*R*counter) + 100;
        left_counter = 3*R*cos(counter) - 2*R*cos(3/2*R*counter);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: MaskWidget(
          top: top_counter,
          left: left_counter,
          blendMode : BlendMode. srcATop,
          childSaveLayer: true,
          mask: Image.memory(
            widget.image,
            height: 400,
            width: 400,
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 50,
              width: 50,
            ),
            ),
          )
    );
  }
}
