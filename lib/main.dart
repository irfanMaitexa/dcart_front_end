import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/screens/bottomnavigationbar.dart';
import 'package:online_grocery_app_ui/screens/loginScreen.dart';
import 'package:online_grocery_app_ui/staff/staff_choose_screen.dart';


void main() {
  runApp(MaterialApp(

    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Gilroy'
    ),
    home: Bottomnavigationbar(),
  ));
}
