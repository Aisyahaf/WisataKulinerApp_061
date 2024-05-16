import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuliner_app/controller/kuliner_controller.dart';
import 'package:kuliner_app/model/kuliner.dart';
import 'package:kuliner_app/screen/home_screen.dart';
import 'package:kuliner_app/screen/map_screen.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key, required this.kuliner});
  final Kuliner kuliner;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final kulinerController = KulinerController();
  final _formKey = GlobalKey<FormState>();
  final _nmTempatController = TextEditingController();
  final _menuController = TextEditingController();
  final _noteController = TextEditingController();

  String? _alamat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Form Wisata Kuliner")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Tempat Wisata",
                    hintText: "Masukkan nama tempat",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  controller: _nmTempatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the name of the tourist spot';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Rekomendasi Menu Makanan",
                    hintText: "Masukkan menu makanan",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  controller: _menuController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a menu recommendation';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Catatan",
                    hintText: "Masukkan catatanmu!!!",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  controller: _menuController,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  border: Border.all(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(5),
                ),
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
              Container(
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var result = await kulinerController.addKuliner(Kuliner(
                          id: widget.kuliner.id,
                          nmTempat: _nmTempatController.text,
                          menu: _menuController.text,
                          note: _noteController.text,
                          alamat: _alamat ?? '',
                        ));

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
                    child: const Text("Update")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
