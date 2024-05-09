import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuliner_app/controller/kuliner_controller.dart';
import 'package:kuliner_app/model/kuliner.dart';
import 'package:kuliner_app/screen/home_screen.dart';
import 'package:kuliner_app/screen/map_screen.dart';

class KulinerForm extends StatefulWidget {
  const KulinerForm({super.key});

  @override
  State<KulinerForm> createState() => _KulinerFormState();
}

class _KulinerFormState extends State<KulinerForm> {
  final kulinerController = KulinerController();
  final _formKey = GlobalKey<FormState>();
  final _nmTempatController = TextEditingController();

  File? _image;
  final _imagePicker = ImagePicker();
  String? _alamat;

  Future<void> getImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print("No Image Selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Wisata Kuliner")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Tempat Wisata",
                      hintText: "Masukkan nama tempat"),
                  controller: _nmTempatController,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat"),
                    _alamat == null
                        ? const SizedBox(
                            width: double.infinity,
                            child: Text('Alamat kosong'))
                        : Text('$_alamat'),
                    _alamat == null
                        ? TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                      onLocationSelected: (selectedAddress) {
                                    setState(() {
                                      _alamat = selectedAddress;
                                    });
                                  }),
                                ),
                              );
                            },
                            child: const Text('Pilih Alamat'),
                          )
                        : TextButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                      onLocationSelected: (selectedAddress) {
                                    setState(() {
                                      _alamat = selectedAddress;
                                    });
                                  }),
                                ),
                              );
                              setState(() {});
                            },
                            child: const Text('Ubah Alamat'),
                          ),
                  ],
                ),
              ),
              _image == null
                  ? const Text("Tidak ada gambar yang dipilih")
                  : Image.file(_image!),
              ElevatedButton(
                onPressed: getImage,
                child: const Text("Pilih Gambar"),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var result = await kulinerController.addKuliner(
                            Kuliner(
                                nmTempat: _nmTempatController.text,
                                alamat: _alamat ?? '',
                                gambar: _image!.path),
                            _image);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result['message'])),
                        );

                        Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()),
                            (route) => false);
                      }
                    },
                    child: const Text("Submit")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
