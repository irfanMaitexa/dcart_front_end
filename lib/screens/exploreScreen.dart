
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'beveragesScreen.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  List<Map<String,dynamic>> list =[
    {
      'image' : 'asset/images/fruits_veg.png',
      'text' : 'Fruits and \nVegetables',
      'color' : Color(0xffF2F3F2)
    },
    {
      'image': 'asset/images/cookingOil.png',
      'text': 'Cooking Oil \nand Ghee',
      'color' : Color(0xffF8A44CB2)
    },
    {
    'image' : 'asset/images/meat_fish.png',
    'text' : 'Meat & Fish',
      'color' : Color(0xffF7A593)
    },
    {
      'image' : 'asset/images/bakery_snacks.png',
      'text' : 'Bakery & Snacks',
      'color' : Color(0xffD3B0E0)
    },
    {
      'image' : 'asset/images/Dairy_eggs.png',
      'text' : 'Dairy & Eggs',
      'color' : Color(0xffFDE598)
    },
    {
      'image' : 'asset/images/beverages.png',
      'text' : 'Beverages',
      'color' : Color(0xffB7DFF5)
    },
    {
      'image' : 'asset/images/bakery_snacks.png',
      'text' : 'Bakery & Snacks',
      'color' : Color(0xffD3B0E0)
    },
    {
      'image' : 'asset/images/cookingOil.png',
      'text' : 'Cooking Oil \nand Ghee',
      'color': Color(0xffF8A44CB2)
    }
  ];

  void bvrg({required BuildContext context,required String category}){

    if(category == 'Beverages'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Beveragesscreen(),));

    }





    }


  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          SizedBox(
            height: 40,
          ),
          Text('Find Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),),
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
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
          ),
          Expanded(
            child: GridView.builder(

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // mainAxisSpacing: 8,
                    // crossAxisSpacing: 8
                    ),
                itemCount: list.length,
                itemBuilder: (BuildContext, int index) {
                  return GestureDetector(
                    onTap: () {
                      bvrg(context: context,category:list[index]['text'] );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: wt/8.23,
                        height: ht/17.99,
                        // color: Color(0xff53B1751A ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: list[index]['color'],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(list[index]['image']),

                              SizedBox(height: 20),

                              Text(list[index]['text'],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black ,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),)

                            ],
                          ),
                        ),

                      ),
                    ),
                  );
                }
                ),
          )
                ],
              ),
        ));
  }
}
