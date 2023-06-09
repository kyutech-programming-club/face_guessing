import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:face_guessing/entity/user_entity.dart';
import 'package:face_guessing/provider/domain_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraProvider = FutureProvider.autoDispose<CameraController?>(
      (ref) async {
    final cameras = ref.read(camerasProvider);
    if (cameras.isEmpty) {
      return null;
    }
    final camera = cameras[1];
    final controller =
    CameraController(camera, ResolutionPreset.high, enableAudio: false);
    await controller.initialize();
    controller.setFlashMode(FlashMode.off);
    return controller;
  },
);

final faceImageProvider = StateProvider<Uint8List?>((ref) => null);

class UserEntitiesNotifier extends Notifier<List<UserEntity>> {
    // We initialize the list of userEntities to an empty list
    @override
    List<UserEntity> build() {
        return [];
    }

    void addUserEntity(UserEntity userEntity) {
        state = [...state, userEntity];
    }

    void removeUserEntity(String userEntityName) {
        state = [
            for (final userEntity in state)
                if (userEntity.name != userEntityName) userEntity,
        ];
    }

    void addScore(String answerUserName) {
        state = [
            for (final userEntity in state)
                userEntity.name != answerUserName ? userEntity : userEntity
                    .copyWith.call(score: userEntity.score + 10),
        ];
    }
    void ClearUserentity(){
        state = [];
    }
}
// Finally, we are using NotifierProvider to allow the UI to interact with
// our userEntitiesNotifier class.
    final userEntitiesProvider = NotifierProvider<UserEntitiesNotifier,
        List<UserEntity>>(() {
        return UserEntitiesNotifier();
    });