import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_grocery_app_ui/baseurl.dart';
import 'package:online_grocery_app_ui/staff/staff_choose_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StaffLoginScreen extends StatefulWidget {
  @override
  _StaffLoginScreenState createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final TextEditingController idController = TextEditingController();
  bool isLoading = false;
  String? idError;

  // Validate Staff ID
  String? validateId(String id) {
    if (id.isEmpty) {
      return 'Staff ID is required';
    } 
    return null;
  }

  // Handle Staff Login
  Future<void> handleStaffLogin() async {
    idError = validateId(idController.text);
    if (idError != null) {
      setState(() {});
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final Map<String, dynamic> requestBody = {
        'random_id': idController.text,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/api/staff/login/'), // Replace with actual API URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Store staff ID in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('staff_id', idController.text);

        // Navigate to Staff Dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StaffDashboardScreen()), // Replace with actual staff dashboard
        );
      } else {
        throw Exception('Invalid Staff ID');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Staff Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: idController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Staff ID',
                      labelStyle: TextStyle(color: Colors.green),
                      errorText: idError,
                      prefixIcon: Icon(Icons.person, color: Colors.green),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: isLoading ? null : handleStaffLogin,
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


