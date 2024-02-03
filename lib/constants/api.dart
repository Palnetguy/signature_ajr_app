import 'package:http/http.dart' as http;

class Api {
  static const apiKey = 'BNzvEEED7XWU6qMkopWiXnz3';

  static var baseUrl = Uri.parse("https://api.remove.bg/v1.0/removebg");

  static removebg(String imgPath) async {
    print("Got Image Path: $imgPath");
    var request = http.MultipartRequest("POST", baseUrl);

    request.headers.addAll({"X-API-Key": apiKey});

    request.files.add(await http.MultipartFile.fromPath("image_file", imgPath));

    final response = await request.send();

    if (response.statusCode == 200) {
      http.Response img = await http.Response.fromStream(response);
      print("Removed BackGround successfully........");
      return img.bodyBytes;
    } else {
      print("Failed to fetch iamge background remover");
      return null;
    }
  }
}
