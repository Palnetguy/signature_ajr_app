import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/homepage.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  // BNzvEEED7XWU6qMkopWiXnz3
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Signature App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePageScreen(),
    );
  }
}
