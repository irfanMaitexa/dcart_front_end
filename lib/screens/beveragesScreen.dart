import 'package:flutter/material.dart';

import '../widgets/homescreenCustomwidget2.dart';

class Beveragesscreen extends StatelessWidget {
   Beveragesscreen({super.key});

   List<Map<String,dynamic>> list= [
     {
       'image' : 'asset/images/cokeDrink.png',
       'title' : 'Diet Coke',
       'subtitle' : '355 ml, Price',
       'price' : 1.99
     },
     {
       'image' : 'asset/images/spriteCan.png',
       'title' : 'Sprite Can',
       'subtitle' : '325 ml, Price',
       'price' : 1.50
     },
     {
       'image' : 'asset/images/apple_grape_juice.png',
       'title' : 'Apple and Grape Juice',
       'subtitle' : '2L, Price',
       'price' : 15.99
     },
     {
       'image' : 'asset/images/orange_juice.png',
       'title' : 'Orange Juice',
       'subtitle' : '2L, Price',
       'price' : 15.99
     },
     {
       'image' : 'asset/images/coco_ cola.png',
       'title' : 'Coca Cola Can',
       'subtitle' : '325 ml,Price',
       'price' : 4.99
     },
     {
       'image' : 'asset/images/pepsi.png',
       'title' : 'Pepsi Can',
       'subtitle' : '325 ml, Price',
       'price' : 4.99
     }
   ];

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50,),
        
            Text('Beverages',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff181725),
              fontWeight: FontWeight.bold
            ),),
        
            SizedBox(height: 30,),
        
            Expanded(
              child: GridView.builder(
                itemCount: list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: .7,

                  ),
                  itemBuilder: (Buildcontext, int index) {
                   return  HomeScreenCustomWidget2(
                     val: list[index],
                     ontab: (){

                     },
                      image: list[index]['image'],
                      title: list[index]['title'],
                      subtitle: list[index]['subtitle'],
                     price: list[index]['price'],
                    );
                  },),
            )
          ],
        ),
      )
    );
  }
}
