import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kuliner_app/model/kuliner.dart';
import 'package:kuliner_app/service/kuliner_service.dart';



class KulinerController {
  final KulinerService _service = KulinerService();

  Future<Map<String,dynamic>> addKuliner(Kuliner kuliner, File? file)async{
    Map<String, String> data = {
      'nmTempat' : kuliner.nmTempat,
      'alamat' : kuliner.alamat,
    };
    
    try{
    var response = await _service.addKuliner(data, file);

    if(response.statusCode == 201){
        return{
          'success' : true,
          'message' : 'Data berhasil disimpan',
        };
      }else{
        if(response.headers['content-type']!.contains('application/json')){
          var decodedJson = jsonDecode(response.body);
          return{
            'success' : false,
            'message' : decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return{
          'success' : false,
          'message' : decodedJson['message'] ?? 'Terjadi Kesalahan saat menyimpan data',
        };
      }
    }catch(e){
      return{
        'success' : false,
        'message' : 'Terjadi kesalahan: $e'
      };
    }
  }

  Future<List<Kuliner>> getKuliner() async {
  try {
    List<dynamic> kulinerData = await _service.fetchKuliner();
    List<Kuliner> kuliner = kulinerData.map((json) => Kuliner.fromMap(json)).toList();
    return kuliner;
  } catch (e) {
    // ignore: avoid_print
    print('Response: $Response');
    print('Exception: $e');
    throw Exception('Failed to get Tempat Wisata');
  }
}
}
