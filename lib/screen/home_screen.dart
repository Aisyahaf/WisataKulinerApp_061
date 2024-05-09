import 'package:flutter/material.dart';
import 'package:kuliner_app/controller/kuliner_controller.dart';
import 'package:kuliner_app/model/kuliner.dart';
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
                return ListTile(
                  title: Text(kuliner.nmTempat),
                  subtitle: Text(kuliner.alamat),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(kuliner.gambar),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KulinerForm())
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
