import 'package:flutter/material.dart';
import 'package:pacil_station_mobile/screens/menu.dart';
import 'package:pacil_station_mobile/screens/product_list_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Text(
                  'Pacil Station',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh Produk disini",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(colorScheme: Theme.of(context).colorScheme),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: const Text('Tambah Product'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
