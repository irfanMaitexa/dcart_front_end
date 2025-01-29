import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/screens/signupScreen.dart';
import 'package:online_grocery_app_ui/utils/helper.dart';

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

  String? phoneError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset('asset/images/carrot_color.png'),
            SizedBox(
              height: 80,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xff181725),
                        fontSize: ht / 34.59,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter your phone number and password',
                    style: TextStyle(color: Color(0xff7C7C7C), fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      labelText: 'Phone', errorText: phoneError),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 35,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      fixedSize: Size(364, 67),
                      backgroundColor: Color(0xff53B175),
                    ),
                    onPressed: () {
                     
                      passwordError =
                          validatePassword(password: passwordController.text);

                      setState(() {});

                      if (phoneError == null && passwordError == null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Bottomnavigationbar(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
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
                            ..onTap = () {}
                            
                            // => Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => SignupScreen()),
                            //     ),
                        )
                      ]),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
