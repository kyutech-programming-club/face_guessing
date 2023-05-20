import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:async';

class QuizButton extends StatelessWidget {
  final double time_counter;
  final void Function() onPressed;
  const QuizButton({Key? key, required this.time_counter, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Button1'),
                style:
                ElevatedButton.styleFrom(
                  primary: Colors.grey[300],
                  onPrimary: Colors.black,
                ),
                onPressed: onPressed,
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
