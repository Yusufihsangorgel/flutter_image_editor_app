import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor/screens/editImageScreen.dart';
import 'package:image_editor/utils/utils.dart';
import 'package:image_editor/widgets/defaultButton.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../models/textInfo.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> textx = [];
  int currentIndex = 0;

  saveToGallery(BuildContext context) {
    if (textx.isNotEmpty) {
      screenshotController
          .capture()
          .then((Uint8List? image) {})
          .catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  removeText() {
    setState(() {
      textx.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Deleted",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Selected for Styling",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  changeTextColor(Color anan) {
    setState(() {
      print("bastı : $anan");
      anan = textx[currentIndex].color;
      print(textx[currentIndex].color);
    });
  }

  increaseFontSize() {
    setState(() {
      textx[currentIndex].fontsize = textx[currentIndex].fontsize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      textx[currentIndex].fontsize = textx[currentIndex].fontsize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      textx[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      textx[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      textx[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      if (textx[currentIndex].fontWeight == FontWeight.bold) {
        textx[currentIndex].fontWeight = FontWeight.normal;
      } else {
        textx[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (textx[currentIndex].fontStyle == FontStyle.italic) {
        textx[currentIndex].fontStyle = FontStyle.normal;
      } else {
        textx[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (textx[currentIndex].text.contains('\n')) {
        textx[currentIndex].text =
            textx[currentIndex].text.replaceAll('\n', ' ');
      } else {
        textx[currentIndex].text =
            textx[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      textx.add(TextInfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontsize: 20,
          textAlign: TextAlign.left));
    });
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Yeni metin ekle"),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: "Metninizi giriniz..."),
        ),
        actions: <Widget>[
          DefaultButton(
              onpressed: () {
                Get.back();
              },
              child: const Text("Geri dön"),
              color: Colors.white,
              textColor: Colors.black),
          DefaultButton(
              onpressed: () => addNewText(context),
              child: const Text("Metin ekle"),
              color: Colors.red,
              textColor: Colors.white)
        ],
      ),
    );
  }
}
