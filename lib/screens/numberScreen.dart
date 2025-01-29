import 'package:flutter/material.dart';
import 'package:online_grocery_app_ui/screens/verificationScreen.dart';
import 'package:phone_form_field/phone_form_field.dart';

class Number extends StatelessWidget {
  const Number({super.key});

  @override
  Widget build(BuildContext context) {
    final ht=MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter your mobile number',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ht/37.48,
                color: Color(0xff181725)
              ),),
            ),

            SizedBox(height: 30,),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('Mobile Number',
              style: TextStyle(
                color: Color(0xff7C7C7C),
                fontWeight : FontWeight.w600,
                fontSize: 16
              ),
              ),
            ),
            SizedBox(height:10,),
            
            PhoneFormField(
              initialValue:
              PhoneNumber.parse('+91'), // or use the controller
              countrySelectorNavigator:
              const CountrySelectorNavigator.page(),
              onChanged: (phoneNumber) =>
                  print('changed into $phoneNumber'),
              enabled: true,
              isCountrySelectionEnabled: true,
              isCountryButtonPersistent: true,
              countryButtonStyle: const CountryButtonStyle(
                  showDialCode: true,
                  showIsoCode: true,
                  showFlag: true,
                  flagSize: 16),
            ),
            
            Spacer(),
            



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => Verificationscreen(),));
        },
        child: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
        backgroundColor: Colors.green,
        shape:CircleBorder()
      ),

    );
  }
}
