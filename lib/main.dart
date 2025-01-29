import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/screens/bottomnavigationbar.dart';
import 'package:online_grocery_app_ui/screens/loginScreen.dart';


void main() {
  runApp(MaterialApp(

    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Gilroy'
    ),
    home: Loginscreen(),
  ));
}
