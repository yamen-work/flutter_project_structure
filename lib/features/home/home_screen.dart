import 'package:exercise_projects/core/widgets/my_custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart_screen/logic/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> products = const ["Apple", "Banana", "Orange", "Grapes"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: width > 600 ? 32 : 20),
        child: ListView(
          children: products.map((product) {
            return ListTile(
              title: Text(product),
              onTap: () {
                context.read<Cart>().add(product); 
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("$product added to cart")),
                );
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(MyCustomIcons.group87),
        onPressed: () {},
      ),
    );
  }
}
