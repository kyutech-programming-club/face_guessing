import 'package:camera/camera.dart';
import 'package:face_guessing/page/home_page.dart';
import 'package:face_guessing/page/quiz/quiz_page.dart';
import 'package:face_guessing/provider/domain_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    availableCameras().then(
        (value) => ref.read(camerasProvider.notifier).update((state) => value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //元はHomePage
        home: QuizPage(),
    );
  }
}
