import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class KulinerService {
  final String baseUrl = 'https://10.0.2.2/apikuliner/';
  final String endpoint = 'api.php';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  Future<http.Response> addKuliner(Map<String, String> data, File? file) async {
  var request = http.MultipartRequest(
    'POST',
    getUri(endpoint),
  )
    ..fields.addAll(data)
    ..headers['Content-Type'] = 'multipart/form-data';

  if (file != null) {
    request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
  }
  return await http.Response.fromStream(await request.send());
}

  // Future<http.Response> addKuliner(Map<String, String> data, File? file) async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     getUri(endpoint),
  //   )
  //     ..fields.addAll(data)
  //     ..headers['Content-Type'] = 'application/json';

  //   if (file != null) {
  //     request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
  //   } else {
  //     request.fields['gambar'] = '';
  //   }
  //   return await http.Response.fromStream(await request.send());
  // }

  // Future<List<dynamic>> fetchKuliner() async {
  //   var response = await http.get(
  //     getUri(endpoint),
  //     headers: {
  //       "Accept": "application/json",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> decodedResponse = json.decode(response.body);
  //     return decodedResponse[endpoint];
  //   } else {
  //     throw Exception('Failed to load kuliner: ${response.reasonPhrase}');
  //   }
  // }

  Future<List<dynamic>> fetchKuliner() async {
    var response = await http.get(
      getUri(endpoint),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedResponse = json.decode(response.body);
      return decodedResponse;
    } else {
      throw Exception(
          'Failed to load wisata kuliner: ${response.reasonPhrase}');
    }
  }
}
