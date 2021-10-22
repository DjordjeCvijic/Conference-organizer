import 'dart:developer';
import 'dart:html';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var pickedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: pickImageFromGallery2, child: Text("stisni"))
        ],
      ),
    );
  }

  pickImageFromGallery2() async {
    var picked = await FilePicker.platform.pickFiles();

    if (picked != null) {
      log(picked.files.first.name);
      Uint8List? uploadfile = picked.files.single.bytes;
      log(uploadfile.toString());
    }
  }

  pickImageFromGallery() async {
    // final imageFile = await ImagePickerWeb.getImageInfo;
    // if (imageFile != null) {
    //   setState(() {
    //     pickedImage = imageFile;
    //     log(imageFile.data);
    //   });
    // }
    // File? imageFile =
    //     (await ImagePickerWeb.getImage(outputType: ImageType.file)) as File?;

    // if (imageFile != null) {
    //   debugPrint(imageFile.name.toString());
    //   log(imageFile.relativePath.toString());
    // }
    //Image? fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.widget);

    //
  }
}
