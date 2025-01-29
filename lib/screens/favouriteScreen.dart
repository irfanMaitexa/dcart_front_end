import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/services/add_to_favourites.dart';

import '../services/add_to_cart.dart';
import '../widgets/custombuttonWidget.dart';
import 'homeScreen.dart';
import 'mycartScreen.dart';

class Favouritescreen extends StatelessWidget {
   Favouritescreen({super.key});



  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Favourites',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xff181725),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: favList.length,
                itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Image.asset( favList[index]['image']),
                        ),
                        // SizedBox(
                        //   width: 40,
                        // ),

                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favList[index]['title'],
                              style: TextStyle(
                                  color: Color(0xff181725),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  favList[index]['subtitle'],
                                  style: TextStyle(
                                      color: Color(0xff7C7C7C), fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: 90,
                        // ),

                        Spacer(),
                        Text(
                          '\$ ${favList[index]['price'].toString()}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 5,
                    )
                  ]));
            })),
            CustomButtonWidget(
              text: 'Add All To Cart',
              action: () {

                favList.forEach((favList) {
                  addToCart(values:favList);
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => Mycartscreen(),));

              },
            )
          ],
        ),
      ),
    );
  }
}
