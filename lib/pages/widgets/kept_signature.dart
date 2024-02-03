// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:syncfusion_flutter_pdf/pdf.dart' as pdfLib;
// import 'pdfviwer_screen.dart';

// class SignatureScreen extends StatefulWidget {
//   final String documentFilePath;
//   const SignatureScreen({Key? key, required this.documentFilePath})
//       : super(key: key);

//   @override
//   _SignatureScreenState createState() => _SignatureScreenState();
// }

// class _SignatureScreenState extends State<SignatureScreen> {
//   final ImagePicker _imagePicker = ImagePicker();
//   Uint8List? _signatureBytes;
//   Offset _signaturePosition = Offset(0, 0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Document Signature'),
//       ),
//       body: Stack(
//         children: [
//           PDFView(
//             filePath: _getPdfFilePath(),
//             onViewCreated: (PDFViewController controller) {},
//           ),
//           if (_signatureBytes != null)
//             Positioned(
//               left: _signaturePosition.dx,
//               top: _signaturePosition.dy,
//               child: Draggable(
//                 feedback: Image.memory(
//                   _signatureBytes!,
//                   width: 100,
//                   height: 50,
//                 ),
//                 child: Image.memory(
//                   _signatureBytes!,
//                   width: 100,
//                   height: 50,
//                 ),
//                 onDraggableCanceled: (_, offset) {
//                   setState(() {
//                     // Set the initial position when drag starts
//                     _signaturePosition = Offset(
//                       offset.dx
//                           .clamp(0, MediaQuery.of(context).size.width - 100),
//                       offset.dy
//                           .clamp(0, MediaQuery.of(context).size.height - 50),
//                     );
//                   });
//                 },
//               ),
//             ),
//           Positioned(
//             bottom: 10,
//             left: 10,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await _pickSignatureImage();
//               },
//               child: Text('Pick Signature'),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: MediaQuery.of(context).size.width / 2 - 50,
//             child: ElevatedButton(
//               onPressed: () async {
//                 await _saveDocumentWithSignature();
//               },
//               child: Text('Save'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickSignatureImage() async {
//     final XFile? pickedImage =
//         await _imagePicker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       final Uint8List data = await pickedImage.readAsBytes();
//       setState(() {
//         _signatureBytes = data;
//         // Set the initial position to the bottom of the PDF
//         _signaturePosition = Offset(
//           (MediaQuery.of(context).size.width - 100) / 2, // Center horizontally
//           MediaQuery.of(context).size.height - 50, // Bottom of the screen
//         );
//       });
//     }
//   }

//   Future<void> _saveDocumentWithSignature() async {
//     if (_signatureBytes != null) {
//       try {
//         final pdfLib.PdfDocument inputDocument = await pdfLib.PdfDocument(
//           inputBytes: File(_getPdfFilePath()).readAsBytesSync(),
//         );

//         final pdfLib.PdfPage page = inputDocument.pages[0];

//         // You can adjust the position and size of the image as needed
//         final image = pdfLib.PdfBitmap(_signatureBytes!);
//         page.graphics.drawImage(
//           image,
//           Rect.fromLTWH(
//             _signaturePosition.dx,
//             _signaturePosition.dy,
//             100, // Width of the image
//             50, // Height of the image
//           ),
//         );

//         final directory = await getApplicationDocumentsDirectory();
//         final filePath = '${directory.path}/edited_pdf_document.pdf';

//         final File file = File(filePath);
//         await file.writeAsBytes(await inputDocument.save());

//         print('PDF saved to: $filePath');

//         List<int> fileBytes = await file.readAsBytes();
//         print('PDF Contents (First 100 bytes): ${fileBytes.sublist(0, 100)}');

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PdfViewerScreen(filePath),
//           ),
//         );
//       } catch (e) {
//         print('Error saving PDF: $e');
//       }
//     }
//   }

//   String _getPdfFilePath() {
//     return widget.documentFilePath;
//   }
// }
