import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/screens/loginScreen.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    print(ht/18.73);

    print(ht);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage('asset/images/8140 1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('asset/images/carrot.png'),
              SizedBox(height: 10,),
              
              Text('Welcome \n to our store',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ht/18.73,
                fontFamily: 'Gilroy',
                color: Colors.white
              ),),
              
              Text('Get your groceries in as fast as one hour',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Gilroy'
              ),),

              SizedBox(height: 40,),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 67,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    fixedSize: Size(353, 67),
                    backgroundColor: Color(0xff53B175),
                  ),
                    onPressed: (){

                    Navigator.push(context,  MaterialPageRoute(builder: (context) => Loginscreen(),));
                    },

                    child: Text('Get Started',
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      color: Colors.white,fontSize: 18
                    ),)
                ),
              ),

              SizedBox(height: 90,)
            ],
          ),

        ),

      ),

    );
  }
}
