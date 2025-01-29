import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_grocery_app_ui/baseurl.dart';
import 'package:online_grocery_app_ui/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<String?> getPhoneNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('phone_number');
}


Future<Map<String, dynamic>> fetchProfile(String phone) async {
   // Replace with your base URL
  final String endpoint = '/customer/$phone/';

  final response = await http.get(Uri.parse(baseUrl + endpoint));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load profile');
  }
}


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

  File? image;
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      String? phone = await getPhoneNumber();
      if (phone != null) {
        Map<String, dynamic> data = await fetchProfile(phone);
        setState(() {
          profileData = data;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load profile: $e')),
      );
    }
  }

  Future<void> pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: Icon(Icons.person, size: 60),
                            ),
                            Positioned(
                              right: -8,
                              bottom: 0,
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await pickImage(source: ImageSource.gallery);
                                              },
                                              child: Text('Gallery'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await pickImage(source: ImageSource.camera);
                                              },
                                              child: Text('Camera'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.add, size: 18, color: Colors.white),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(10),
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileData?['name'] ?? 'Afsar Hossen',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              profileData?['phone'] ?? 'Imshuvo97@gmail.com',
                              style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 5),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(height: 5),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Image.asset(list[index]['image']),
                              SizedBox(width: 15),
                              Text(
                                list[index]['text'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios_rounded),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(364, 67),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Loginscreen()),
                        (route) => false,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.green),
                        Center(
                          child: Text(
                            'Log Out',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}


