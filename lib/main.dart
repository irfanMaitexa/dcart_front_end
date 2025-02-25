import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/firebase_options.dart';
import 'package:online_grocery_app_ui/screens/loginScreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(

    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Gilroy'
    ),
    home: Loginscreen(),
  ));
}
