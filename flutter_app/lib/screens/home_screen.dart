import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter_app/custom_widgets/custom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img_pack;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = "HomeScreenID";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? resizedImage;
  bool isImageAdded = false;
  String tumorType = "";

  void uploadImageToCloud(File imageFile) async {
    var request = http.MultipartRequest('POST',
        Uri.https("breast-cancer-cloud-production.up.railway.app", "/api"));

    var image = http.MultipartFile.fromBytes(
        'image', imageFile.readAsBytesSync(),
        filename: "image.png");
    request.files.add(image);

    // Get the response from the server
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var resultAsString = String.fromCharCodes(responseData);
    var resultAsJson = jsonDecode(resultAsString);

    final tumorTypes = {
      "0": "No Tumor",
      "1": "Benign Tumor",
      "2": "Malignant Tumor"
    };

    tumorType = tumorTypes[resultAsJson["Tumor Detection"]]!;
    setState(() {});
  }

  File resizeImage(File imageFile) {
    final image = img_pack.decodeImage(imageFile.readAsBytesSync());
    if (image == null) return imageFile;
    final resizedImage = img_pack.copyResize(image, width: 256, height: 256);
    imageFile.writeAsBytesSync(img_pack.encodePng(resizedImage));
    return imageFile;
  }

  void pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    final pickedImageFile = File(pickedImage.path);
    resizedImage = resizeImage(pickedImageFile);
    uploadImageToCloud(resizedImage!);
    Navigator.pop(context);
    isImageAdded = true;
    setState(() {});
  }

  void showModalSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.pink.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return CustomBottomSheet(
          onCameraTap: () => pickImage(ImageSource.camera),
          onGalleryTap: () => pickImage(ImageSource.gallery),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalSheet(),
        elevation: 10,
        backgroundColor: Colors.pink,
        label: const Text(
          "ADD IMAGE",
          style: TextStyle(fontSize: 20),
        ),
        icon: Icon(Icons.add, color: Colors.pink.shade50),
      ),
      drawer: const CustomDrawer(),
      appBar: AppBar(backgroundColor: Colors.pink.shade400, elevation: 0),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffee9ca7), Color(0xffffdde1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.pink.shade400,
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.all(20),
                child: Visibility(
                  visible: isImageAdded,
                  replacement: const Center(
                    child: Text("ADD IMAGE",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                  child: resizedImage == null
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(resizedImage!)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.pink, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(Icons.output),
                      title:
                          Text("Tissue State", style: TextStyle(fontSize: 25)),
                      subtitle: Text(tumorType, style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
