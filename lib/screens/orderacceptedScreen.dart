import 'package:flutter/material.dart';

import '../widgets/custombuttonWidget.dart';
import 'bottomnavigationbar.dart';
import 'homeScreen.dart';

class Orderacceptedscreen extends StatelessWidget {
  const Orderacceptedscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:110 ,),

          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset('asset/images/orderaccept.png',
              width: wt/1.52,
              height: ht/3.74,
              // alignment: Alignment.center,
                      ),
            ),
          ),

          Text('Your Order has been accepted',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ht/32.12,
            fontWeight: FontWeight.w600,
          )
          ),
          SizedBox(height: 15,),
          
          Text('Your item has been placed and is on \nits way to being processed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff7C7C7C)
          ),),

          SizedBox(height: 90,),

          CustomButtonWidget(
            text: 'Track Order',
            action: (){

            },
          ),
          
          TextButton(
            onPressed: () {  
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Bottomnavigationbar(),), (route) => false);
            },
            child: Text('Back to home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff181725)
              ),
            ),
          )
      ],
      ),
    );
  }
}
