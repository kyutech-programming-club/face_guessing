import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String name,
    required Uint8List imageValue,
    required int score,
  }) = _UserEntity;
}