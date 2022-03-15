import 'package:flutter/material.dart';
import 'package:image_editor/screens/editImageScreen.dart';
import 'package:image_editor/widgets/defaultButton.dart';
import 'package:get/get.dart';

import '../models/textInfo.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  List<TextInfo> textx = [];
  int currentIndex = 0;

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Selected for Styling",
      style: TextStyle(fontSize: 16),
    )));
  }

  changeTextColor(Color color) {
    setState(() {
      print("bastı");
      textx[currentIndex].color = color;
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
