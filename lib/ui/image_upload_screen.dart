import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickandgo/ui/confirm_order_screen.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  //initialization
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  //image picker method
  Future imagePickerMethod() async {
    //pick image
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showSnacBar("No image selected", Duration(milliseconds: 400));
      }
    });
  }

  //upload image to firebase storage
  Future uploadImage() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    Reference ref = FirebaseStorage.instance.ref().child("images");
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    showSnacBar("Image uploaded successfully", Duration(seconds: 3));
    print(downloadURL);

    //await firebaseFirestore
    //.collection("confirmed_orders")
    //.doc(uid)
    //.collection("images")
    //.add({'imageURL': downloadURL}).whenComplete(() =>
  }

  // snackbar to show errors
  showSnacBar(String snacText, Duration d) {
    final snackBar = SnackBar(content: Text(snacText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Upload"),
        backgroundColor: Color(0xffF5591F),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 550,
              width: double.infinity,
              child: Column(
                children: [
                  const Text("Upload Your Image"),
                  const SizedBox(height: 10),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color(0xffF5591F))),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _image == null
                                ? const Center(
                                    child: Text("No image selected !"))
                                : Image.file(_image!),
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffF5591F)),
                              ),
                              onPressed: () {
                                imagePickerMethod();
                              },
                              child: Text("Select image")),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xffF5591F)),
                              ),
                              onPressed: () {
                                if (_image != null) {
                                  uploadImage();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConfirmOrder()));
                                } else {
                                  showSnacBar("Pleas select an image",
                                      Duration(milliseconds: 400));
                                }
                              },
                              child: Text("Upload")),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
