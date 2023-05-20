import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class QuizButtonRight extends StatelessWidget {
  final double time_counter;
  const QuizButtonRight({Key? key, required this.time_counter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 3 * pi / 2,
                child: ElevatedButton(
                  child: const Text('Button'),
                  style:
                  ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          FAProgressBar(
            currentValue: time_counter,
            maxValue: 30,
            progressColor: Colors.green,
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.up,
          ),
        ],
      ),
    );
  }
}
