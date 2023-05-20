import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  const QuizButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('Button1'),
            style:
            ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              onPrimary: Colors.black,
            ),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Text('Button2'),
            style:
            ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              onPrimary: Colors.black,
            ),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Text('Button3'),
            style:
            ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              onPrimary: Colors.black,
            ),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Text('Button4'),
            style:
            ElevatedButton.styleFrom(
              primary: Colors.grey[300],
              onPrimary: Colors.black,
            ),
            onPressed: () {},
          )

        ],
      ),
    );
  }
}
