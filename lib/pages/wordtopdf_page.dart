import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class WordToPdfConverter extends StatefulWidget {
  @override
  _WordToPdfConverterState createState() => _WordToPdfConverterState();
}

class _WordToPdfConverterState extends State<WordToPdfConverter> {
  late Uint8List _pdfBytes;

  // Future<void> _pickDocument() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //     );

  //     print('FilePickerResult: $result');

  //     if (result != null && result.files.isNotEmpty) {
  //       String filePath = result.files.first.path!;
  //       _pdfBytes = await File(filePath).readAsBytes();
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) => SignatureScreen(documentFilePath: filePath),
  //         ),
  //       );
  //     } else {
  //       print('No file picked or result is null.');
  //     }
  //   } catch (e) {
  //     print('Error picking document: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showComingSoonModal(
                "This Feature of converting Word to PDF is under Development. Check later for use.");
          },
          child: Text('Pick Word Document'),
        ),
      ),
    );
  }

  void _showComingSoonModal(String message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Text(
            message,
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }
}
