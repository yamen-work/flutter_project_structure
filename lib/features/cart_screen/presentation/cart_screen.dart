import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          return ListView(
            children: cart.items.map((item) {
              return ListTile(
                title: Text(item),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => context.read<Cart>().remove(item),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}