import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff53B175),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
                child: Image.asset('asset/images/Group 1.png'),
              ),



        ],
      ),
    );
  }
}
