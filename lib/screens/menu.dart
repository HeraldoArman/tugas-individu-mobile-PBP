import 'package:flutter/material.dart';
import '../interface/item_home_page.dart';
import '../widgets/info_card.dart';
import "../widgets/left_drawer.dart";

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required ColorScheme colorScheme});

  final List<ItemHomepage> items = [
    ItemHomepage(
      name: "All Products",
      icon: Icons.shopping_bag,
      color: Colors.blueAccent,
    ),
    ItemHomepage(
      name: "My Products",
      icon: Icons.shopping_cart,
      color: const Color.fromARGB(255, 236, 29, 255),
    ),
    ItemHomepage(
      name: "Create Product",
      icon: Icons.add_box,
      color: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman dengan AppBar dan body.
    return Scaffold(
      // AppBar adalah bagian atas halaman yang menampilkan judul.
      appBar: AppBar(
        title: const Text(
          'Pacil Station',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Warna latar belakang AppBar diambil dari skema warna tema aplikasi.
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: LeftDrawer(),

      // Body halaman dengan padding di sekelilingnya.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Menyusun widget secara vertikal dalam sebuah kolom.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Memberikan jarak vertikal 16 unit.
            const SizedBox(height: 16.0),

            // Menempatkan widget berikutnya di tengah halaman.
            Center(
              child: Column(
                // Menyusun teks dan grid item secara vertikal.
                children: [
                  // Grid untuk menampilkan ItemCard dalam bentuk grid 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // Agar grid menyesuaikan tinggi kontennya.
                    shrinkWrap: true,

                    // Menampilkan ItemCard untuk setiap item dalam list items.
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item: item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
