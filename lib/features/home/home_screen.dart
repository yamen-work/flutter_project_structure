import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow.shade200,
        child: Column(
          children: [
            Center(child:Icon(Icons.home, color: Colors.amber, size: 60)),
          ],
        ),
      ),
    );
  }
}
