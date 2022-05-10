import 'package:elnaamy_group/locale/localizations.dart';
import 'package:flutter/material.dart';

class ConnectUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context).connectUs),
          backgroundColor: Color(0xff00577d),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.asset('assets/images/logo-about.png'),
                ),
                _textWithTextField(
                  textUP: AppLocalizations.of(context).userName,
                ),
                _textWithTextField(
                  textUP:  AppLocalizations.of(context).email,
                ),
                _textWithTextField(
                  textUP:  AppLocalizations.of(context).phone,
                ),
                _textWithTextField(
                    textUP:  AppLocalizations.of(context).message,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6),
                SizedBox(height: 25),
                Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xff143240),
                  ),
                  child: FlatButton(
                    child: Text(
                      AppLocalizations.of(context).send,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ));
  }

  Widget _textWithTextField(
      {String textUP,
      TextInputType keyboardType,
      String hintText,
      String labelText,
      String helperText,
      FormFieldSetter<String> onSave,
      ValueChanged<String> onFieldSubmitted,
      TextEditingController controller,
      int maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          textUP,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          maxLines: maxLines,
          style: TextStyle(height: .5, color: Colors.black),
          keyboardType: keyboardType,
          onSaved: onSave,
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black26,
              ),
            ),
            hintText: hintText,
            helperText: helperText,
            labelStyle: TextStyle(
              color: Colors.black54,
            ),
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
          ),
          textAlign: TextAlign.start,
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter full name';
            }
            return null;
          },
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
