import 'package:flutter/material.dart';

class ServiceNoteRservation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reservation Page"),
        backgroundColor: Color(0xff00577d),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[350],
                ),
                child: FlatButton(
                  child: Text(
                    "reserve service",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              
              _textWithTextField(textUP: "choose branche"),
              _textWithTextField(textUP: "date"),
              _textWithTextField(textUP: "time"),
              _textWithTextField(textUP: "notes"),

              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xff00577d),
                  ),
                  child: FlatButton(
                    child: Text(
                      "Complete Reservetion",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _textWithTextField({
    String textUP,
    TextInputType keyboardType,
    String hintText,
    String labelText,
    String helperText,
    FormFieldSetter<String> onSave,
    ValueChanged<String> onFieldSubmitted,
    TextEditingController controller,
  }) {
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
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}