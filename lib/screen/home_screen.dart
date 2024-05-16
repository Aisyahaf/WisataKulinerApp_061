import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<Kuliner>>(
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
                                    menu: kuliner.menu,
                                    note: kuliner.note,
                                    alamat: kuliner.alamat,
                                    // gambar: kuliner.gambar,
                                  ))));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontFamily: 'RobotoSlab',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1, child: Icon(Icons.restaurant)),
                                  Expanded(
                                    flex: 4,
                                    child: Text(kuliner.nmTempat),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1, child: Icon(Icons.location_on)),
                                  Expanded(
                                      flex: 4, child: Text(kuliner.alamat)),
                                ],
                              ),
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
                                                  menu: kuliner.menu,
                                                  note: kuliner.note,
                                                  alamat: kuliner.alamat,
                                                  // gambar: kuliner.gambar,
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
                                                  onPressed: () async {
                                                    await _controller
                                                        .deleteKuliner(
                                                            kuliner.id);
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
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
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
