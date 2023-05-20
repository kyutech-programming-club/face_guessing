import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class Face extends StatelessWidget {
  const Face({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: WidgetMask(
        blendMode : BlendMode. srcATop,
        childSaveLayer: true,
          mask: Image.network(
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
            height: 300,
            width: 300,
          ),
          child: Center(
            child: Container(
              color: Colors.white,
              height: 100,
              width: 100,
            ),
          )
      ),
    );
  }
}
