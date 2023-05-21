import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/presentation_provider.dart';

class QuizButtonRight extends ConsumerWidget {
  final double time_counter;
  final void Function() onPressed;
  const QuizButtonRight({Key? key, required this.time_counter, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score4 = ref.watch(userEntitiesProvider)[3].score;
    final name4 = ref.watch(userEntitiesProvider)[3].name;
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 3 * pi / 2,
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
                    Row(
                      children: [
                        Text(name4),
                        Chip(
                          label: Text("$score4 pt"),
                          backgroundColor: Colors.yellow,
                        ),
                      ],
                    )
                  ],
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
