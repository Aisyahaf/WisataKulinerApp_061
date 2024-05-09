import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kuliner_app/model/kuliner.dart';
import 'package:kuliner_app/service/kuliner_service.dart';

class KulinerController {
  final KulinerService _service = KulinerService();

  Future<Map<String, dynamic>> addKuliner(Kuliner kuliner, File? file) async {
    Map<String, String> data = {
      'nmTempat': kuliner.nmTempat,
      'alamat': kuliner.alamat,
    };

    try {
      var response = await _service.addKuliner(data, file);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data berhasil disimpan',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat menyimpan data',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  Future<List<Kuliner>> getKuliner() async {
    try {
      List<dynamic> kulinerData = await _service.fetchKuliner();
      List<Kuliner> kuliner =
          kulinerData.map((json) => Kuliner.fromMap(json)).toList();
      return kuliner;
    } catch (e) {
      // ignore: avoid_print
      print('Response: $Response');
      print('Exception: $e');
      throw Exception('Failed to get Tempat Wisata');
    }
  }

  Future<Map<String, dynamic>> editKuliner(
      Kuliner kuliner, File? file, String id) async {
    Map<String, String> data = {
      'nmTempat': kuliner.nmTempat,
      'alamat': kuliner.alamat,
    };

    try {
      var response = await _service.editKuliner(data, file, id);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Data berhasil diubah',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat mengubah data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  Future<Map<String, dynamic>> deleteKuliner(String id) async {
    try {
      var response = await _service.deleteKuliner(id);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Data berhasil dihapus',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat menghapus data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
