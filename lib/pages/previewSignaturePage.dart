import 'dart:async';
import 'dart:io' show Directory, File, Platform;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:AJR_Ink/constants/api.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:image/image.dart' as Img;
import 'package:connectivity_plus/connectivity_plus.dart';

class ReviewSignaturePage extends StatefulWidget {
  final Uint8List signature;
  const ReviewSignaturePage({Key? key, required this.signature})
      : super(key: key);

  @override
  State<ReviewSignaturePage> createState() => _ReviewSignaturePageState();
}

class _ReviewSignaturePageState extends State<ReviewSignaturePage> {
  static String imagePath = "";
  static var isRemoveBg = false;
  static bool hasInternetConnection = false;

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();

    // Subscribe to the stream for connectivity changes
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      updateConnectionStatus(result);
    });

    // Check initial connectivity status
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    updateConnectionStatus(connectivityResult);
  }

  void updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      setState(() {
        hasInternetConnection = false;
      });
    } else {
      setState(() {
        hasInternetConnection = true;
      });
    }
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 35,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => saveSignature(context),
            icon: const Icon(
              Icons.save,
              size: 35,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text('Save Signature'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.memory(widget.signature),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isRemoveBg = false;
                      });
                      saveSignature(context);
                      print(isRemoveBg);
                    },
                    child: Text('Save Signature'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isRemoveBg = true;
                      });

                      if (isRemoveBg & hasInternetConnection) {
                        if (kDebugMode) {
                          print(isRemoveBg);
                          print(
                              "You Have an internet Connection: $hasInternetConnection");
                        }
                        saveSignature(context);
                        // removeSignatureBg(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text("Please Check Your Internet Connection"),
                                  Text(
                                    "You need internet Connection to Remove Signature Background",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Remove Background'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveSignature(BuildContext context) async {
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // Making signature name unique
    final time = DateTime.now().toIso8601String().replaceAll('.', '_');
    final name = 'signature_$time.png';

    final result =
        await ImageGallerySaver.saveImage(widget.signature, name: name);
    final isSuccessful = result['isSuccess'];

    if (isSuccessful & isRemoveBg == false) {
      Navigator.pop(context);
      Get.snackbar('Success', 'Signature saved to device',
          backgroundColor: Colors.white, colorText: Colors.green);
      return;
    } else if (isRemoveBg) {
      Get.snackbar('Success', 'Signature saved to device',
          backgroundColor: Colors.white, colorText: Colors.green);
      removeSignatureBg(context);
      return;
    } else {
      Get.snackbar('Failure', 'Signature not saved to device',
          backgroundColor: Colors.red, colorText: Colors.white);
      print(isRemoveBg);
    }
  }
}

Future<void> removeSignatureBg(BuildContext context) async {
  final ImagePicker _imagePicker = ImagePicker();
  final XFile? pickedImage =
      await _imagePicker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    // print(pickedImage.path);
    // print(basename(pickedImage.path));
    var imagename = basename(pickedImage.path);
    var removedbgImage = await Api.removebg(pickedImage.path);

    final result = await ImageGallerySaver.saveImage(removedbgImage,
        name: "nobackground_$imagename");
    final isSuccessful = result['isSuccess'];

    if (isSuccessful) {
      Navigator.pop(context);
      Get.snackbar(
          'Success', 'Successfully saved and removed signature background',
          backgroundColor: Colors.white, colorText: Colors.green);
      return;
    } else {
      Get.snackbar('Failure', 'Failed to Save and Remove Signature background',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
  }
}

// Future<String> getImageMemoryPath() async {
//   final time = DateTime.now().toIso8601String().replaceAll('.', '_');
//   final name = 'signature_$time.png';

//   Directory tempDir = await getTemporaryDirectory();
//   String tempPath = tempDir.path;

//   File imageFile = File('$tempPath/$name');
//   print("The Image path in memeory is:  ${imageFile.path}");
//   return imageFile.path;
// }
  // Future<Uint8List> removeWhiteBackground(Uint8List bytes) async {
  //   Img.Image? image = Img.decodeImage(bytes);
  //   Img.Image transparentImage = await colorTransparent(image!, 255, 255, 255);
  //   var newPng = Img.encodePng(transparentImage);
  //   return newPng;
  // }

  // Future<Img.Image> colorTransparent(
  //     Img.Image src, int red, int green, int blue) async {
  //   var pixels = src.getBytes();
  //   for (int i = 0, len = pixels.length; i < len; i += 4) {
  //     if (pixels[i] == red && pixels[i + 1] == green && pixels[i + 2] == blue) {
  //       pixels[i + 3] = 0;
  //     }
  //   }

  //   return src;
  // }

