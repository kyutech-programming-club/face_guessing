import 'package:face_guessing/entity/user_entity.dart';
import 'package:face_guessing/page/register/component/confirm_page.dart';
import 'package:face_guessing/provider/presentation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(MaterialApp(
    home: NamePage(),
  ));
}

final myController = TextEditingController();

class NamePage extends ConsumerStatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends ConsumerState<NamePage> {
  @override
  Widget build(BuildContext context) {
    final image = ref.watch(faceImageProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('名前'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                image != null ? Image.memory(image) : const SizedBox.shrink(),
                SizedBox(height: 24,),
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '名前',
                  ),
                ),
                ElevatedButton(
                  child: Text('確定'),
                  onPressed: () {
                    final inputname = myController.text;
                    ref.read(userEntitiesProvider.notifier).addUserEntity(UserEntity(name: inputname, imageValue: image!, score: 0));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmPage(),
                      ),
                    );
                  },
                ),
              ],
            )
        )
    );
  }
}
