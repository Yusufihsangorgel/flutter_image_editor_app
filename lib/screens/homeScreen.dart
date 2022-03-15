import 'package:flutter/material.dart';
import 'package:image_editor/screens/editImageScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.upload_file),
          onPressed: () async {
            XFile? file = await _picker.pickImage(
              source: ImageSource.gallery,
            );
            if (file != null) {
              Get.to(EditImageScreen(selectedImage: file.path));
            }
          },
        ),
      ),
    );
  }
}
