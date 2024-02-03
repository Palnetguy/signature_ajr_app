import 'package:flutter/material.dart';
import 'package:AJR_Ink/pages/signatureTab_screen.dart';
import 'package:AJR_Ink/pages/signaturescreen.dart';
import 'package:AJR_Ink/pages/widgets/bottomnavigation_widget.dart';
import 'package:AJR_Ink/constants/constants.dart';
import 'homeview_screen.dart';
import 'pdfviwer_screen.dart';
import 'previewSignaturePage.dart';
import 'settings_page.dart';
import 'signconvert_tabbar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;
  final List _listPages = [];
  Widget? _currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listPages
      ..add(const HomePageScreenView())
      // ..add(const SignatureScreen())
      ..add(const SignatureTabScreen())
      // ..add(const ReviewSignaturePage())
      ..add(const SignConvertTabBar())
      ..add(const UserSettingsScreen());
    // ..add(const PdfViewerScreen());

    _currentPage = const HomePageScreenView();
  }

  void changePageIndex(index) {
    print("Changing Index page......");
    setState(() {
      _currentIndex = index;
      _currentPage = _listPages[index];
    });
    print("Changed Index page......: $_currentIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _currentPage,
      bottomNavigationBar: bottomNavWidget(changePageIndex),
    );
  }
}
