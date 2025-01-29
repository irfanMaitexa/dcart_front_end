import 'dart:io';

import 'package:flutter/material.dart';

import 'loginScreen.dart';

import 'package:image_picker/image_picker.dart';

class Accountscreen extends StatefulWidget {
  Accountscreen({super.key});

  @override
  State<Accountscreen> createState() => _AccountscreenState();
}

class _AccountscreenState extends State<Accountscreen> {
  List<Map<String, dynamic>> list = [
    {'image': 'asset/images/ordersIconAccount.png', 'text': 'Orders'},
    {'image': 'asset/images/MyDetailsiconAccount.png', 'text': 'My Details '},
    {'image': 'asset/images/de;iveryAccount.png', 'text': 'Delivery Address'},
    {'image': 'asset/images/paymentAccount.png', 'text': 'Payment Method'},
    {'image': 'asset/images/promocodeAccount.png', 'text': 'Promo Code'},
    {'image': 'asset/images/belliconAccount.png', 'text': 'Notifications'},
    {'image': 'asset/images/helpiconAccount.png', 'text': 'Help'},
    {'image': 'asset/images/abouticonAccount.png', 'text': 'About'}
  ];

  File ? image;





  // // This is the image picker
  Future<void> pickImage({required ImageSource source}) async {


    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    image = File(pickedImage!.path);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;



    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Stack(
                  children:[
                    CircleAvatar(
                    radius:60,
                      backgroundImage:image==null ? AssetImage("assets/images/Profile Image.png") :FileImage(image!) ,


                  ),

                    Positioned(
                        right: -8,
                        bottom: 0,
                        child: ElevatedButton(

                          onPressed: () {
                            showModalBottomSheet(
                                context: context, builder: (context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,

                                      children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              pickImage(source: ImageSource.gallery);



                                            }, child: Text('Gallery')),
                                        ElevatedButton(
                                            onPressed: () async {

                                              Navigator.pop(context);
                                              pickImage(source: ImageSource.camera);


                                            }, child: Text('Camera'))
                                      ],
                                    ),
                                  );
                                });


                          },
                          child: Icon(Icons.add,size: 18, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Colors.blue, // <-- Button color
                            foregroundColor: Colors.red, // <-- Splash color
                          ),
                        )
                    )

        ],
      ),

                SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Afsar Hossen',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      'Imshuvo97@gmail.com',
                      style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                height: 5,
              ),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Image.asset(list[index]['image']),
                      SizedBox(
                         width: 15,
                      ),
                      Text(
                        list[index]['text'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(
            height: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // backgroundColor: Color(0xff53B175),
                  fixedSize: Size(364, 67)),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginscreen(),), (route) => false,);
              },
              child: Row(
                children: [
                  Icon(Icons.logout,
                  color: Colors.green,),

                  Center(
                    child: Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
