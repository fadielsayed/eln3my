import 'package:flutter/material.dart';
import 'package:pin_code_view/pin_code_view.dart';

class NotActivated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinCode(
        title: Text(
          "Pin Code",
          style: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        subTitle: Text(
          "Eln3amy  Groups",
          style: TextStyle(color: Colors.white),
        ),
        obscurePin: true, // to make pin * instead of number
        codeLength: 4,
        
      ),
    );
  }
}
