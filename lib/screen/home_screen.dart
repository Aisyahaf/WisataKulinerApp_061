import 'package:flutter/material.dart';
import 'package:kuliner_app/controller/kuliner_controller.dart';
import 'package:kuliner_app/model/kuliner.dart';
import 'package:kuliner_app/screen/detail_screen.dart';
import 'package:kuliner_app/widget/edit_form.dart';
import 'package:kuliner_app/widget/kuliner_form.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final KulinerController _controller = KulinerController();

  @override
  void initState() {
    super.initState();
    _controller.getKuliner();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wisata Kuliner Yogyakarta"),
      ),
      body: FutureBuilder<List<Kuliner>>(
        future: _controller.getKuliner(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Eror: ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                Kuliner kuliner = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                    kuliner: Kuliner(
                                      id: kuliner.id,
                                  nmTempat: kuliner.nmTempat,
                                  alamat: kuliner.alamat,
                                  gambar: kuliner.gambar,
                                ))));
                  },
                  child: ListTile(
                    title: Text(kuliner.nmTempat),
                    subtitle: Text(kuliner.alamat),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(kuliner.gambar),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditForm(
                                            kuliner: Kuliner(
                                              id: kuliner.id,
                                          nmTempat: kuliner.nmTempat,
                                          alamat: kuliner.alamat,
                                          gambar: kuliner.gambar,
                                        ))));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    title: Text('Hapus Data ini??'),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async{
                                            await _controller.deleteKuliner(kuliner.id! as String);
                                              Navigator.of(context).pop();
                                          },
                                          child: Text('Hapus')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Batal')),
                                    ],
                                  );
                                }));
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KulinerForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
