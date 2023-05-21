import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:async';

class QuizButton extends StatelessWidget {
  final int score;
  final Color color;
  final double time_counter;
  final void Function() onPressed;
  final String name;
  const QuizButton({
    Key? key,
    required this.time_counter,
    required this.onPressed,
    required this.score,
    required this.color,
    required this.name
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                      Text(name),
                      Chip(
                        label: Text("$score pt"),
                        backgroundColor: color,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          FAProgressBar(
            currentValue: time_counter,
            maxValue: 30,
            progressColor: Colors.green,
          )
        ],
      ),
    );
  }
}
