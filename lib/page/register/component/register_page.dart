import 'dart:typed_data';

import 'package:face_guessing/page/camera/camera_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'confirm_page.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.read(faceImageProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null ? Image.memory(image) : const SizedBox.shrink(),
            ElevatedButton(
              child: Text('登録する'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPage(),
                  ),
                );
              },
            ),           ElevatedButton(
              child: Text('スタート'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
