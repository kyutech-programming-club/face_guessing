import 'dart:io';

import 'package:face_guessing/constant/color_constant.dart';
import 'package:face_guessing/page/home_page.dart';
import 'package:face_guessing/page/register/component/confirm_page.dart';
import 'package:face_guessing/page/register/name_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:face_guessing/utils/context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as image;

class TakePictureButton extends ConsumerWidget {
  const TakePictureButton({
    Key? key,
    required this.left,
    required this.top,
  }) : super(key: key);
  final double left;
  final double top;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 72,
      height: 72,
      child: FloatingActionButton(
        onPressed: () async {
          final image = await ref.read(cameraProvider).value!.takePicture();
          final data = await File(image.path).readAsBytes();
          final targetImage = fromByteData(data);

          final Uint8List cropResult = await compute(
            doCrop,
            [
              targetImage,
              Rect.fromLTWH(
                20,
                top * targetImage.height / context.screenHeight + 60,
                context.screenWidth * targetImage.width / context.screenWidth,
                580 * targetImage.height / context.screenHeight,
              ),
            ],
          );
          ref.read(faceImageProvider.notifier).update((state) => cropResult);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NamePage(),
            ),
          );
        },
        child: Icon(Icons.camera_alt, size: 32),
        backgroundColor: ColorConstant.purple40,
      ),
    );
  }
}

Uint8List doCrop(List<dynamic> cropData) {
  final originalImage = cropData[0] as image.Image;
  final rect = cropData[1] as Rect;
  return Uint8List.fromList(
    image.encodePng(
      image.copyCrop(
        originalImage,
        x: rect.left.toInt(),
        y: rect.top.toInt(),
        width: rect.width.toInt(),
        height: rect.height.toInt(),
      ),
    ),
  );
}

image.Image fromByteData(Uint8List data) {
  final tempImage = image.decodeImage(data);
  assert(tempImage != null);
  if (tempImage!.width > tempImage.height) {
    return image.copyRotate(tempImage, angle: 90);
  } else {
    return tempImage;
  }

  // check orientation
  // switch (tempImage.exif.exifIfd.orientation ?? -1) {
  //   case 3:
  //     return image.copyRotate(tempImage, angle: 180);
  //   case 6:
  //
  //   case 8:
  //     return image.copyRotate(tempImage, angle: -90);
  // }
  // return tempImage;
}