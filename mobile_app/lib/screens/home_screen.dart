import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/custom_widgets/custom_bottom_sheet.dart';
import 'package:mobile_app/custom_widgets/custom_drawer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String id = "HomeScreenID";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? croppedImage;
  bool isImageAdded = false;

  void postData(data) async {
    var response = await http.get(
      Uri.https("breastcancerdetectionapp-production.up.railway.app", "/"),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    File img = File(pickedImage.path);
    croppedImage = await cropImage(imageFile: img);
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
  void initState() {
    super.initState();
    // loadModel();
  }

  // void loadModel() async {
  //   try {
  //     var inputImage = TensorImage.fromFile(croppedImage!);
  //     ImageProcessor imageProcessor = ImageProcessorBuilder()
  //         .add(ResizeOp(244, 244, ResizeMethod.NEAREST_NEIGHBOUR))
  //         .build();
  //     inputImage = imageProcessor.process(inputImage);
  //     TensorBuffer probabilityBuffer =
  //         TensorBuffer.createFixedSize(<int>[244, 244], TfLiteType.uint8);
  //     Interpreter interpreter = await Interpreter.fromAsset("tumor.tflite");
  //     interpreter.run(inputImage.buffer, probabilityBuffer.buffer);
  //   } catch (e) {
  //     print('Error loading model: ' + e.toString());
  //   }
  // }

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
                  child: croppedImage == null
                      ? Container()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(croppedImage!)),
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
                    const ListTile(
                      leading: Icon(Icons.output),
                      title:
                          Text("Tissue State", style: TextStyle(fontSize: 25)),
                      subtitle: Text("Tumor", style: TextStyle(fontSize: 18)),
                    ),
                    const ListTile(
                      leading: Icon(Icons.photo_size_select_small_sharp),
                      title: Text("Tumor Relative Size",
                          style: TextStyle(fontSize: 25)),
                      subtitle: Text("20%", style: TextStyle(fontSize: 18)),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          postData({"id": "1", "name": "sherif"});
                        },
                        child: const Text("Test API"))
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
