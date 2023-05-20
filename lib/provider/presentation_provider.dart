import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:face_guessing/provider/domain_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraProvider = FutureProvider.autoDispose<CameraController?>(
      (ref) async {
    final cameras = ref.read(camerasProvider);
    if (cameras.isEmpty) {
      return null;
    }
    final camera = cameras.first;
    final controller =
    CameraController(camera, ResolutionPreset.high, enableAudio: false);
    await controller.initialize();
    controller.setFlashMode(FlashMode.off);
    return controller;
  },
);

final faceImageProvider = StateProvider<Uint8List?>((ref) => null);

final Player1Score = StateProvider<int>((ref) => 0);
final Player2Score = StateProvider<int>((ref) => 0);
final Player3Score = StateProvider<int>((ref) => 0);
final Player4Score = StateProvider<int>((ref) => 0);