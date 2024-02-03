import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:signature/signature.dart';
import 'package:AJR_Ink/constants/constants.dart';
import 'package:AJR_Ink/pages/previewSignaturePage.dart';

import 'widgets/bottomnavigation_widget.dart';

class SignatureTabScreen extends StatefulWidget {
  const SignatureTabScreen({Key? key}) : super(key: key);

  @override
  State<SignatureTabScreen> createState() => _SignatureTabScreenState();
}

class _SignatureTabScreenState extends State<SignatureTabScreen> {
  SignatureController? controller;

  int _currentIndex = 0;

  @override
  void initState() {
    // we initialize the signature controller
    controller = SignatureController(penStrokeWidth: 5, penColor: Colors.white);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void changePageIndex(index) {
    print("Changing Index page......");
    setState(() {
      _currentIndex = index;
    });
    print("Changed Index page......: $_currentIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 15,
            ),
            child: const Text(
              "Create Your signature Here",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            child: Signature(
              controller: controller!,
              backgroundColor: Colors.teal.shade300,
            ),
          ),
          buttonWidgets(context)!,
          // buildSwapOrientation(context)!,
        ],
      ),
    );
  }

  Widget? buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        controller!.clear();

        setOrientation(newOrientation);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            // const SizedBox(
            //   width: 12,
            // ),
            // const Text(
            //   'Tap to change signature orientation',
            //   style: TextStyle(fontWeight: FontWeight.w600),
            // ),
          ],
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget? buttonWidgets(BuildContext context) => Container(
        color: Colors.teal,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () async {
                if (controller!.isNotEmpty) {
                  final signature = await exportSignature();

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) =>
                          ReviewSignaturePage(signature: signature!)),
                    ),
                  );

                  controller!.clear();
                }
              },
              iconSize: 40,
              color: Colors.white,
              icon: const Icon(Icons.check)),
          IconButton(
            onPressed: () {
              controller!.clear();
            },
            iconSize: 40,
            color: Colors.red,
            icon: const Icon(Icons.close),
          ),
          buildSwapOrientation(context)!,
        ]),
      );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      points: controller!.points,
    );

    final signature = exportController.toPngBytes();

    //clean up the memory
    exportController.dispose();

    return signature;
  }
}
