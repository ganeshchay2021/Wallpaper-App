import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:wallpaperapp/service/database.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  final List<String> categoryItems = ["Wildlife", "Foods", "Nature", "City"];
  String? value;

  final ImagePicker _imagePicker = ImagePicker();
  File? selectedImage;

  Future getImage() async {
    try {
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      } else {
        // User canceled the picker
        const Text("No image selected.");
      }
    } catch (e) {
      Text("Error picking image: $e");
    }
  }

  uploadItem() async {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {"Image": downloadUrl, "id": addId};

      await DatabaseMethods().addWallpaper(addItem, addId, value!).then(
            (value) => Fluttertoast.showToast(
              msg: "Details Added Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Wallpaper",
          style:
              TextStyle(fontSize: height * 0.023, fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.046,
            ),
            selectedImage == null
                ? GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Center(
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: height * 0.34,
                          width: width * 0.72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: height * 0.34,
                        width: width * 0.72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: height * 0.046,
            ),
            Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: height * 0.013),
              margin: EdgeInsets.symmetric(horizontal: height * 0.023),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: categoryItems
                      .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                                fontSize: height * 0.020, color: Colors.black),
                          )))
                      .toList(),
                  onChanged: (value) {
                    setState(
                      () {
                        this.value = value;
                      },
                    );
                  },
                  
                  hint: const Text("Select the category"),
                  value: value,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.050,
            ),
            GestureDetector(
              onTap: () {
                uploadItem();
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.065,
                width: width,
                padding: EdgeInsets.symmetric(vertical: height * 0.013),
                margin: EdgeInsets.symmetric(horizontal: width * 0.048),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.012),
                    color: Colors.black),
                child: Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.025,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
