import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/baseurl.dart';
import 'homeScreen.dart';
import 'package:http/http.dart' as http;

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  String? validatePhone(String phone) {
    if (phone.isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  Future<void> handleSignUp() async {
  final phoneError = validatePhone(phoneController.text);
  if (phoneError != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(phoneError)),
    );
    return;
  }

  setState(() {
    isLoading = true;
  });

  try {
    // Prepare the request body
    final Map<String, dynamic> requestBody = {
      'name': usernameController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
    };

    // Make the API call
    final response = await http.post(
      Uri.parse('$baseUrl/api/register/'), // Replace with your actual API endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    // Check the response status code
    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      
       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(responseData["message"])),
    );
    Navigator.pop(context);
     
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toString())),
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
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
                  const SizedBox(height: 60),
                  Image.asset('asset/images/carrot_color.png'),
                  const SizedBox(height: 60),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign Up',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: const Color(0xff181725),
                            fontSize: ht / 34.59,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter your credentials to continue',
                          style: TextStyle(
                            color: Color(0xff7C7C7C),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(labelText: 'Username'),
                      ),
                      const SizedBox(height: 35),
                      TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                      ),
                      const SizedBox(height: 35),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          suffixIcon: Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          text: 'By continuing you agree to our ',
                          style: TextStyle(color: Colors.black38, fontSize: 14),
                          children: [
                            TextSpan(
                              text: 'Terms of Service ',
                              style: TextStyle(color: Colors.green, fontSize: 14),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(color: Colors.black38, fontSize: 14),
                            ),
                            TextSpan(
                              text: 'Privacy Policy ',
                              style: TextStyle(color: Colors.green, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fixedSize: const Size(364, 67),
                          backgroundColor: const Color(0xff53B175),
                        ),
                        onPressed: isLoading ? null : handleSignUp,
                        child: isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}
