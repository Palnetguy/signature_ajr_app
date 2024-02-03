import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pdfLib;
import '../constants/api.dart';
import 'pdfviwer_screen.dart';

class SignatureScreen extends StatefulWidget {
  final String documentFilePath;

  const SignatureScreen({Key? key, required this.documentFilePath})
      : super(key: key);

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? _signatureBytes;
  Offset _signaturePosition = Offset(0, 0);
  Offset _signatureIndicatorPosition = Offset(0, 0);
  late PDFViewController pdfViewController;
  late int pageNumber = 0;
  late bool showSignature = false;
  var removedbg = false;

  GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Document Signature'),
        ),
        body: Stack(
          children: [
            SfPdfViewer.file(
              File(_getPdfFilePath()),
              onTap: (details) {
                if (_signatureBytes == null) {
                  _showAlertDialog(
                      "Pick Signature", "Please pick your signature.");
                  return;
                }
                setState(() {
                  pageNumber = details.pageNumber;
                  _signaturePosition = details.pagePosition;
                  _signatureIndicatorPosition = details.position;
                  print('Signature Page Position: $_signaturePosition');
                  print(
                      'Signature StackWidget Position: $_signatureIndicatorPosition');
                  showSignature = true;
                  // _showSignatureImage();
                });
              },
            ),
            if (showSignature && _signatureBytes != null)
              Positioned(
                left: _signatureIndicatorPosition.dx,
                top: _signatureIndicatorPosition.dy,
                // top: _signaturePosition.dy,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            Positioned(
              bottom: 10,
              left: 10,
              child: ElevatedButton(
                onPressed: () async {
                  await _pickSignatureImage();
                },
                child: Text('Pick Signature'),
              ),
            ),
            // SizedBox(
            //   width: 20,
            // ),
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 2 - 10,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveDocumentWithSignature();
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSignatureImage() {
    print("Has Benn Called");
    if (_signatureBytes != null) {
      setState(() {
        // Show the signature image at the tapped location
        // _signaturePosition = Offset(
        //   _signaturePosition.dx - 50, // Adjusting for image width
        //   _signaturePosition.dy - 25, // Adjusting for image height
        // );
        showSignature = true;
        print("Has Now Worked");
      });
    }
  }

  Future<void> _pickSignatureImage() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      print(pickedImage.path);
      // var removedbgImage = await Api.removebg(pickedImage.path);
      var removedbgImage = await Api.removebg(pickedImage.path);
      _showSnackBar("Signature image picked successfully!");
      final Uint8List data = await pickedImage.readAsBytes();
      final Uint8List removedbgdata = await removedbgImage;
      setState(() {
        if (removedbgImage != null) {
          _signatureBytes = removedbgdata;
        }
        // _signatureBytes = data;
      });

      // _showInstructionSnackBar("Click anywhere on the PDF to Sign.");
      // _showInstructionModal(
      //     "Scroll and click anywhere on the PDF where the signature should be placed.\nOn clicking the pdf, a red dot will be displayed indicating where your signature will be placed.");
    }
  }

  Future<void> _saveDocumentWithSignature() async {
    if (_signatureBytes == null) {
      _showAlertDialog("Pick Signature", "Please pick your signature.");
      return;
    }
    if (_signaturePosition == Offset(0, 0)) {
      _showInstructionModal(
          "Scroll and click anywhere on the PDF where the signature should be placed.\nOn clicking the pdf, a red dot will be displayed indicating where your signature will be placed.");
      return;
    }

    try {
      final pdfLib.PdfDocument inputDocument = await pdfLib.PdfDocument(
        inputBytes: File(_getPdfFilePath()).readAsBytesSync(),
      );

      final pdfLib.PdfPage page = inputDocument.pages[pageNumber - 1];

      // You can adjust the position and size of the image as needed
      final image = pdfLib.PdfBitmap(_signatureBytes!);
      page.graphics.drawImage(
        image,
        Rect.fromLTWH(
          _signaturePosition.dx,
          _signaturePosition.dy,
          100, // Width of the image
          50, // Height of the image
        ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/edited_pdf_document.pdf';

      final File file = File(filePath);
      await file.writeAsBytes(await inputDocument.save());

      print('PDF saved to: $filePath');

      List<int> fileBytes = await file.readAsBytes();
      print('PDF Contents (First 100 bytes): ${fileBytes.sublist(0, 100)}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(filePath),
        ),
      );
    } catch (e) {
      print('Error saving PDF: $e');
    }
  }

  String _getPdfFilePath() {
    return widget.documentFilePath;
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showInstructionSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        elevation: BorderSide.strokeAlignCenter,
        content: Row(
          children: [
            Icon(Icons.info, color: Colors.white),
            SizedBox(width: 8),
            Text(message),
          ],
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _showInstructionModal(String message) {
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
