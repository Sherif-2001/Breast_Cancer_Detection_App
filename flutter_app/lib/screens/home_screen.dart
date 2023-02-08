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
  Image? resizedImage;
  bool isImageAdded = false;
  bool isOutputAdded = true;
  String tumorType = "";

  void uploadImageToCloud(File imageFile) async {
    var request = http.MultipartRequest('POST',
        Uri.https("breast-cancer-cloud-production.up.railway.app", "/api"));

    var image = http.MultipartFile.fromBytes(
      'image',
      imageFile.readAsBytesSync(),
      filename: "image.png",
    );
    request.files.add(image);

    // Get the response from the server
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var resultAsString = String.fromCharCodes(responseData);
    var resultAsJson = jsonDecode(resultAsString);

    final tumorTypes = {
      "0": "Benign Tumor",
      "1": "Malignant Tumor",
      "2": "No Tumor",
    };

    tumorType = tumorTypes[resultAsJson["Tumor Detection"]]!;

    if (resultAsJson["Tumor Detection"] == "0") {
      resizedImage = Image.asset(
        "assets/benign_tumor.jpeg",
        fit: BoxFit.cover,
      );
    } else if (resultAsJson["Tumor Detection"] == "1") {
      resizedImage = Image.asset(
        "assets/malignant_tumor.jpeg",
        fit: BoxFit.cover,
      );
    }

    isOutputAdded = true;
    setState(() {});
  }

  File resizeImage(File imageFile) {
    final image = img_pack.decodeImage(imageFile.readAsBytesSync());
    if (image == null) return imageFile;
    final resizedImage = img_pack.copyResize(image, width: 150, height: 150);
    imageFile.writeAsBytesSync(img_pack.encodePng(resizedImage));
    return imageFile;
  }

  void pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    isOutputAdded = false;
    final pickedImageFile = File(pickedImage.path);
    Navigator.pop(context);
    resizedImage = Image.file(
      pickedImageFile,
      fit: BoxFit.contain,
    );
    final resizedImageFile = resizeImage(pickedImageFile);
    uploadImageToCloud(resizedImageFile);
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () => showModalSheet(),
          elevation: 10,
          backgroundColor: Colors.pink,
          child: Icon(Icons.add_a_photo, color: Colors.pink.shade50),
        ),
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
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Visibility(
                  visible: isImageAdded,
                  replacement: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "Click",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Icon(Icons.add_a_photo, color: Colors.white, size: 25),
                        Text(
                          "to add an image",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: resizedImage,
                    ),
                  ),
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
                child: Visibility(
                  visible: isOutputAdded,
                  replacement: const Center(
                    child: CircularProgressIndicator(color: Colors.pink),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.output),
                        title: const Text(
                          "Tissue State",
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          tumorType,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
