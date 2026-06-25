import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.redAccent.shade200,
        child: Center(
          child: Icon(Icons.settings, color: Colors.red.shade900, size: 60),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
      },child: Icon(Icons.settings),),
    );
  }
}
