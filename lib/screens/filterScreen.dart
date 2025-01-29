import 'package:flutter/material.dart';

import '../widgets/checkboxCustomwidget.dart';

class Filterscreen extends StatefulWidget {
   Filterscreen({super.key});

  @override
  State<Filterscreen> createState() => _FilterscreenState();
}

class _FilterscreenState extends State<Filterscreen> {
  bool ? check1=true;
  bool ? check2=false;

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(

            children: [
              SizedBox(height: 50,),

              Center(
                child: Text('Filters',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff181725),
                      fontWeight: FontWeight.bold
                  ),),
              ),

              SizedBox(height: 30,),

              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xffF2F3F2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ht/37.48,
                          color: Color(0xff181725)
                        )),
                      ),

                      Checkboxcustomwidget(
                        value: check1, text: 'Eggs',
                      ),
                      Checkboxcustomwidget(
                        value: check2, text: 'Noodles and pasta',
                      ),
                      Checkboxcustomwidget(
                        value: check2, text: 'Chips and Crips',
                      ),
                      Checkboxcustomwidget(
                        value: check2, text: 'Fast Food',
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text('Brand',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ht/37.48,
                                color: Color(0xff181725)
                            )),
                      ),
                      Checkboxcustomwidget(
                        value: check1, text: 'Individual Collection',
                      ),
                      Checkboxcustomwidget(
                        value: check1, text: 'Cocola',
                      ),
                      Checkboxcustomwidget(
                        value: check1, text: 'Ifad',
                      ),
                      Checkboxcustomwidget(
                        value: check1, text: 'Kazi farmas',
                      ),


                    ],
                  ),


                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
