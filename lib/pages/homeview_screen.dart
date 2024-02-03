import 'package:flutter/material.dart';
import 'package:AJR_Ink/constants/constants.dart';

class HomePageScreenView extends StatefulWidget {
  const HomePageScreenView({super.key});

  @override
  State<HomePageScreenView> createState() => _HomePageScreenViewState();
}

class _HomePageScreenViewState extends State<HomePageScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        // elevation: 1.2,
        leading: Container(
          // margin: EdgeInsets.only(),
          // padding: EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 20),

          child: const Row(
            children: [
              Icon(
                Icons.star_purple500_rounded,
                size: 28,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "TAK Devs",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        leadingWidth: 150.0,
        title: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: buttonColor5,
              // borderRadius: BorderRadius.circular(50),
              shape: BoxShape.circle,
              border: Border.all(
                style: BorderStyle.none,
              ),
              boxShadow: const [
                BoxShadow(
                  color: buttonColor6,
                  blurRadius: 8,
                  blurStyle: BlurStyle.solid,
                )
              ]),
          // height: 70,
          // width: 20,
          child: const Column(
            children: [
              Text(
                "29",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                ),
              ),
              Text(
                "mine",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        toolbarHeight: 110,
        actions: const [
          Icon(
            Icons.share_rounded,
            size: 30,
          ),
          SizedBox(
            width: 30,
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 20,
            ),
            child: Icon(
              Icons.menu,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: buttonColor2,
                  image: DecorationImage(
                    image: AssetImage("assets/group.jpg"),
                    // colorFilter:
                    //     ColorFilter.mode(buttonColor2, BlendMode.color),
                    fit: BoxFit.cover,
                    opacity: 0.4,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Features",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            featuresWidgets(),
            const SizedBox(
              height: 25,
            ),
            featuresWidgets2(),
          ],
        ),
      ),
    );
  }
}

Widget featuresWidgets() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: buttonColor1,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner_sharp,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Digital Signature")
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: buttonColor3, shape: BoxShape.circle),
              child: const Icon(
                Icons.fiber_new,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("PDF Signing")
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: buttonColor2, shape: BoxShape.circle),
              child: const Icon(
                Icons.edit_square,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("PDF Editing")
          ],
        ),
      ),
    ],
  );
}

Widget featuresWidgets2() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: buttonColor1,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.slow_motion_video_outlined,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Slideshow Creator")
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: buttonColor3, shape: BoxShape.circle),
              child: const Icon(
                Icons.edit_document,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Word to PDF")
          ],
        ),
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: buttonColor2, shape: BoxShape.circle),
              child: const Icon(
                Icons.text_fields_sharp,
                size: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Text to PDF")
          ],
        ),
      ),
    ],
  );
}
