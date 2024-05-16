import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuliner_app/model/kuliner.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.kuliner,
  });

  final Kuliner kuliner;

  @override
  State<DetailScreen> createState() => _DetailScreenState(kuliner);
}

class _DetailScreenState extends State<DetailScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nmTempat = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController menu = TextEditingController();
  TextEditingController note = TextEditingController();

  Kuliner kuliner;
  _DetailScreenState(this.kuliner);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Wisata Kuliner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Tempat Wisata Kuliner"),
                    subtitle: Text(kuliner.nmTempat),
                  ),
                  ListTile(
                    title: const Text("Rekomendasi Makanan"),
                    subtitle: Text(kuliner.menu),
                  ),
                  ListTile(
                    title: const Text("Catatan"),
                    subtitle: Text(kuliner.note),
                  ),
                  ListTile(
                    title: const Text("Alamat Wisata Kuliner"),
                    subtitle: Text(kuliner.alamat),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
