import 'package:flutter/material.dart';
import 'package:learning_management_app/models/cart_model.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  static const routeName = 'catalog-screen';
  CatalogScreen({super.key});

  final List<Item> catalog = [
    Item(name: 'Item 1'),
    Item(name: 'Item 2'),
    Item(name: 'Item 3')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: catalog.length,
        itemBuilder: (context, index) {
          final item = catalog[index];
          return ListTile(
            title: Text(item.name),
            trailing: ElevatedButton(
              onPressed: () {
                // Add item to the cart
                Provider.of<CartModel>(context, listen: false).add(item);
              },
              child: Text('Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}
