import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/screens/my_order_screen.dart';

import 'accountScreen.dart';
import 'favouriteScreen.dart';
import 'homeScreen.dart';
import 'mycartScreen.dart';
import 'searchScreen.dart';

class Bottomnavigationbar extends StatefulWidget {
  Bottomnavigationbar({super.key, this.zone, this.area});

  String? zone;
  String? area;

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  List<Widget> pages = [];
  int selectedIndex = 0;

  @override
  void initState() {
    pages.addAll([
      Homescreen(zone: widget.zone, area: widget.area),
      Mycartscreen(),
      CustomerOrdersScreen(customerId: 1,), // Placeholder for Orders screen
      Accountscreen()
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: SizedBox(
        height: 90,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                label: 'Explore',
                icon: Icon(Icons.manage_search, color: Colors.black)),
            BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.black)),
            BottomNavigationBarItem(
                label: 'Orders',
                icon: Icon(Icons.receipt_long, color: Colors.black)), // Orders icon
            BottomNavigationBarItem(
                label: 'Account',
                icon: Icon(Icons.account_box_outlined, color: Colors.black))
          ],
          selectedLabelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
