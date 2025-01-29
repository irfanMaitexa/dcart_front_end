import 'package:flutter/material.dart';

import 'locationScreen.dart';

class Verificationscreen extends StatelessWidget {
  const Verificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht= MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter your 4-digit code',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ht/48.48,
                    color: Color(0xff181725)
                ),),
            ),

            SizedBox(height: 30,),

            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text('Code',
            //     style: TextStyle(
            //         color: Color(0xff7C7C7C),
            //         fontWeight : FontWeight.w600,
            //         fontSize: 16
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20,),

            TextField(
              decoration: InputDecoration(
                  labelText: 'Code',
              ),
            ),

            Spacer(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Resend Code',
              style: TextStyle(
                color: Colors.green,
                fontSize: 18
              ),),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){

            // Navigator.push(context, MaterialPageRoute(builder: (context) => Locationscreen(),));
          },
          child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
          backgroundColor: Colors.green,
          shape:CircleBorder()
      ),
    );
  }
}
