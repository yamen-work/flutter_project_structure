import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {

  final List<String> items = [];

  void add(String item) {
    items.add(item);
    notifyListeners();
  }
  void remove(String item) {
    items.remove(item);
    notifyListeners();
  }

  int get count => items.length;
}