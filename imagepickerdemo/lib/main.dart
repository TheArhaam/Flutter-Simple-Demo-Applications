import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ImagePickerWidget());
}

class ImagePickerWidget extends StatelessWidget {
  Image img;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Picker Demo'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Select Image'),
              onPressed: () async {
                img = Image.file(await ImagePicker.pickImage(source: ImageSource.gallery));
              },
            )
          ],
        ),
      ),
    );
  }
}
