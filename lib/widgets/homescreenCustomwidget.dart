import 'package:flutter/material.dart';

class HomeScreenCustomWidget extends StatelessWidget {
   HomeScreenCustomWidget({super.key, required this.text1, required this.text2});

  String text1;
  String text2;


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: TextStyle(
                  color: Color(0xff181725),
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            Text(
              text2,
              style: TextStyle(
                  color: Color(0xff53B175),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );

  }
}
