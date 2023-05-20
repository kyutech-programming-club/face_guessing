import 'package:flutter/material.dart';
import 'dart:math';

class QuizButtonRight extends StatelessWidget {
  const QuizButtonRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 3 * pi / 2,
            child: ElevatedButton(
              child: const Text('Button4'),
              style:
              ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                onPrimary: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          Transform.rotate(
            angle: 3 * pi / 2,
            child: ElevatedButton(
              child: const Text('Button3'),
              style:
              ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                onPrimary: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          Transform.rotate(
            angle: 3 * pi / 2,
            child: ElevatedButton(
              child: const Text('Button2'),
              style:
              ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                onPrimary: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
          Transform.rotate(
            angle: 3 * pi / 2,
            child: ElevatedButton(
              child: const Text('Button1'),
              style:
              ElevatedButton.styleFrom(
                primary: Colors.grey[300],
                onPrimary: Colors.black,
              ),
              onPressed: () {},
            ),
          )

        ],
      ),
    );
  }
}
