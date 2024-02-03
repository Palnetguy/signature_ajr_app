import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'signaturescreen.dart';

class DocumentPickerScreen extends StatefulWidget {
  @override
  _DocumentPickerScreenState createState() => _DocumentPickerScreenState();
}

class _DocumentPickerScreenState extends State<DocumentPickerScreen> {
  late Uint8List _pdfBytes;

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      print('FilePickerResult: $result');

      if (result != null && result.files.isNotEmpty) {
        String filePath = result.files.first.path!;
        _pdfBytes = await File(filePath).readAsBytes();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SignatureScreen(documentFilePath: filePath),
          ),
        );
      } else {
        print('No file picked or result is null.');
      }
    } catch (e) {
      print('Error picking document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _pickDocument,
          child: Text('Pick PDF To attach  signature'),
        ),
      ),
    );
  }
}
