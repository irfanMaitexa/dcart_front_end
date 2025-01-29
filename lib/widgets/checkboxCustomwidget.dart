import 'package:flutter/material.dart';

class Checkboxcustomwidget extends StatefulWidget {
   Checkboxcustomwidget({super.key,required this.value, required this.text});

 bool ? value;
 String  text;

  @override
  State<Checkboxcustomwidget> createState() => _CheckboxcustomwidgetState();
}

class _CheckboxcustomwidgetState extends State<Checkboxcustomwidget> {


  @override
  Widget build(BuildContext context) {
    return   CheckboxListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
      value: widget.value,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool ? value) {

        setState(() {
          widget.value = value;
        }
        );


      },
      title: Text(widget.text),
      activeColor: Colors.green,
    );
  }
}
