import 'package:flutter/material.dart';

import 'document_pickerpage.dart';
import 'otherformatsconvert_page.dart';
import 'wordtopdf_page.dart';

class SignConvertTabBar extends StatefulWidget {
  const SignConvertTabBar({super.key});

  @override
  State<SignConvertTabBar> createState() => _SignConvertTabBarState();
}

class _SignConvertTabBarState extends State<SignConvertTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign & Convert Documents",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.blueGrey.shade50,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.picture_as_pdf),
                text: "Sign PDF",
              ),
              Tab(
                icon: Icon(Icons.published_with_changes_outlined),
                text: "Word To PDF",
              ),
              Tab(
                icon: Icon(Icons.file_copy_rounded),
                text: "Other  formats",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          DocumentPickerScreen(),
          WordToPdfConverter(),
          OtherFormatConvert(),
        ]),
      ),
    );
  }
}
