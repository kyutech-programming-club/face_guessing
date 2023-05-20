import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import '../../../provider/presentation_provider.dart';
import 'quiz_button.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class QuizButtonLeft extends ConsumerWidget {
  final double time_counter;
  final void Function() onPressed;
  const QuizButtonLeft({Key? key, required this.time_counter, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final score2 = ref.watch(userEntitiesProvider)[1].score;
    return Scaffold(
      body: Row(
        children: [
          FAProgressBar(
            currentValue: time_counter,
            maxValue: 30,
            progressColor: Colors.green,
            direction: Axis.vertical,
            verticalDirection: VerticalDirection.down,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: pi / 2,
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Text('Answer'),
                      style:
                      ElevatedButton.styleFrom(
                        primary: Colors.grey[300],
                        onPrimary: Colors.black,
                      ),
                      onPressed: onPressed,
                    ),
                    Chip(
                      label: Text("$score2 pt"),
                      backgroundColor: Colors.cyanAccent,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
