import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/services/add_to_cart.dart';

import '../widgets/homescreenCustomwidget.dart';
import '../widgets/homescreenCustomwidget2.dart';
import 'mycartScreen.dart';

class Homescreen extends StatelessWidget {
   Homescreen({super.key,this.zone,this.area});
   String ? zone;
   String ? area;

   List<Map<String,dynamic>> list1= [
     {
       'id' : '1',
       'image' : 'asset/images/banana.png',
       'title' : 'Organic Banana',
       'subtitle' : '7pc, Priceg',
       'price' : 4.99,
       'quantity' : 1
     },
     {
       'id' : '2',
       'image' : 'asset/images/apple.png',
       'title' : 'Red Apple',
       'subtitle' : '1kg, Priceg',
       'price' : 4.99,
       'quantity' : 1
     },
     ];

   List<Map<String,dynamic>> list2=[
     {
       'id' :'3',
       'image' : 'asset/images/tomato.png',
       'title' : 'Tomato',
       'subtitle' : '1kg Price ',
       'price' : 4.99,
       'quantity' : 1
     },
     {
       'id' : '4',
       'image' : 'asset/images/ginger.png',
       'title' : 'Ginger',
       'subtitle' : '500gm, Priceg',
       'price' : 4.99,
       'quantity' : 1
     }
   ];

   List<Map<String,dynamic>> groc= [
     {
       'image' : 'asset/images/pulses.png',
       'text' : 'Pulses',
       'color' : Color(0xffF8A44C)
     },
     {
       'image' : 'asset/images/rice.png',
       'text' : 'Rice',
       'color' : Color(0xff53B175)
     }
   ];

   List<Map<String,dynamic>> list3=[
     {
       'id' : '5',
      'image' : 'asset/images/beef.png',
      'title' : 'Beef Bone',
      'subtitle' :  '1kg, Priceg',
       'price' : 4.99,
       'quantity' : 1
     },
     {
       'id' : '6',
       'image' : 'asset/images/chicken.png',
       'title' : 'Broiler Chicken',
       'subtitle' : '1kg, Priceg',
       'price' : 4.99,
       'quantity' : 1
     }
   ];

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF2F3F2),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Store',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                  ),
                ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: wt/1.12,
                          height: ht/7.82,
                          child:  Image.asset('asset/images/banner.png')
                        ),
                      ),


                      HomeScreenCustomWidget(
                        text1: 'Exclusive Offer',
                        text2: 'See all',

                      ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list1.length,
                    itemBuilder: (context, index) {
                      return HomeScreenCustomWidget2(
                        val: list1[index],
                        ontab: () {
                          addToCart(values:list1[index]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Mycartscreen(),));
                        },


                        image: list1[index]['image'],
                        title: list1[index]['title'],
                        subtitle: list1[index]['subtitle'],
                        price: list1[index]['price'],

                      );
                    },
                  ),
                ),





                HomeScreenCustomWidget(
                  text1: 'Best Selling',
                  text2: 'See all',

                ),

                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: list2.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return HomeScreenCustomWidget2(
                        val: list2[index],
                        ontab: () {
                          addToCart(values:list2[index]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Mycartscreen(),));

                        },
                          image: list2[index]['image'],
                          title: list2[index]['title'],
                          subtitle: list2[index]['subtitle'],
                        price: list2[index]['price'],
                      );
                    },
                  ),
                ),



                      HomeScreenCustomWidget(
                        text1: 'Groceries',
                        text2: 'See all',

                      ),



                Container(
                  height: ht/4.99,
                  child: ListView.builder(
                    itemCount: groc.length,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Card(
                          color: groc[index]['color'],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            height: ht/8.57,
                            width: wt/1.65,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal:12),
                              child: Row(
                                children: [
                                  Image.asset(groc[index]['image'],
                                  width: wt/5.72,
                                  height: ht/12.50,),

                                  SizedBox(width: 40,),

                                  Text(groc[index]['text'],
                                    style: TextStyle(
                                      color: Color(0xff3E423F),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                    ),)
                                ],
                              ),
                            ),

                          ),
                        );
                      }),
                ),

                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: list3.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return  HomeScreenCustomWidget2(
                        val: list3[index],
                        ontab: (){
                          addToCart(values:list3[index]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Mycartscreen(),));
                        },
                              image: list3[index]['image'],
                              title: list3[index]['title'],
                              subtitle: list3[index]['subtitle'],
                        price: list3[index]['price'],
                      );

                    },
                  ),
                ),

                SizedBox(height: 50,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
