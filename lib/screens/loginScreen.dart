import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_app_ui/baseurl.dart';
import 'dart:convert';
import 'package:online_grocery_app_ui/screens/signupScreen.dart';
import 'package:online_grocery_app_ui/staff/staff_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottomnavigationbar.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false; // Add loading state

  String? phoneError;
  String? passwordError;

  // Validate password
  String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Handle login
  Future<void> handleLogin() async {
    // Validate inputs
    phoneError = validatePhone(phoneController.text);
    passwordError = validatePassword(password: passwordController.text);

    if (phoneError != null || passwordError != null) {
      setState(() {});
      return;
    }

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      final Map<String, dynamic> requestBody = {
        'phone': phoneController.text,
        'password': passwordController.text,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/api/login/'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('phone_number', phoneController.text);
        prefs.setString('customer_id',responseData['customer']['id'].toString());

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomnavigationbar()),
          (route) => false,
        );
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Validate phone number
  String? validatePhone(String phone) {
    if (phone.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Image.asset('asset/images/carrot_color.png'),
                  SizedBox(height: 80),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Color(0xff181725),
                              fontSize: ht / 34.59,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter your phone number and password',
                          style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 35),
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                            labelText: 'Phone', errorText: phoneError),
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 35),
                      TextField(
                        obscureText: obscureText,
                        controller: passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: passwordError,
                            suffixIcon: IconButton(
                                icon: Icon(obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off_outlined),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                })),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fixedSize: Size(364, 67),
                          backgroundColor: Color(0xff53B175),
                        ),
                        onPressed: isLoading ? null : handleLogin,
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Log In',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(color: Colors.green),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signupscreen()));
                                  },
                              )
                            ]),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StaffLoginScreen()), // Replace with actual staff login screen
                          );
                        },
                        child: Text(
                          'Login as Staff',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}

// Replace this with the actual staff login screen

