import 'package:exercise_projects/Localization/l10n/app_localization.dart';
import 'package:exercise_projects/core/widgets/drawer.dart';
import 'package:exercise_projects/features/order/presentation/screens/order_history_screen.dart';
import 'package:exercise_projects/features/products_screen/presentation/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../../core/routing/routing.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> screens = [Container(), ProductsScreen(), OrderHistory()];

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Bloc State Management",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.cart);
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      drawer: CustomDrawer(),
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        height: 100,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          currentIndex: currentIndex,
          showSelectedLabels: true,

          selectedLabelStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),

          selectedIconTheme: IconThemeData(color: Colors.blue),

          onTap: (value) {
            debugPrint("the current index is  : $value");

            setState(() {
              currentIndex = value;
            });
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: AppLocalizations.of(context)!.profile,
            ),
          ],
        ),
      ),
    );
  }
}
