import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wfm/utlis/globalVariables.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CustomImagePicker extends StatefulWidget {
  final Function() notifyParent;

  CustomImagePicker({super.key, required this.notifyParent});

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? image;
  late Uint8List imageBytes;

  // late String imageStr;
  // late String imageName;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {});
    print("refresh is called");

    setState(() async {
      image = img; //xfile
      print("Image $image");
      //  imageBytes = await image!.readAsBytes();
      // print("Image Bytes $imageBytes");
      imageBytes = await testComporessList(await image!.readAsBytes());
      imageName = image!.name;
      print("Image Name $imageName");
      imageStr = base64.encode(imageBytes);
      print("Image String $imageStr");
    });
  }

  Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 700,
      minWidth: 500,
      quality: 50,
      // rotate: 135,
    );
    print(list.length);
    print(result.length);
    return result;
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // myAlert();
            getImage(ImageSource.camera);
          },
          child: const Text('Upload Photo'),
        ),
        const SizedBox(
          height: 10,
        ),
        //if image not null show the image
        //if image null show text
        image != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    //to show image, you type like this.
                    File(image!.path),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              )
            : const Text(
                "No Image!",
                style: TextStyle(fontSize: 20),
              )
      ],
    );
  }
}
