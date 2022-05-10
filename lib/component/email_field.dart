import 'package:elnaamy_group/locale/localizations.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final String textUp;
  final TextInputType keyboardType;

  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;

  const EmailField(
      {Key key,
      this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSave,
      this.onFieldSubmitted,
      this.controller,
      this.textUp = "",
      this.keyboardType})
      : super(key: key);
  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.textUp,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            style: TextStyle(height: .5, color: Colors.black),
            keyboardType: widget.keyboardType,
            key: widget.fieldKey,
            onSaved: widget.onSave,
            onFieldSubmitted: widget.onFieldSubmitted,
            controller: widget.controller,
            decoration: InputDecoration(
              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: Colors.black26,
              //   ),
              // ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black26,
                ),
              ),
              hintText: widget.hintText,
              helperText: widget.helperText,
              labelStyle: TextStyle(
                color: Colors.black54,
              ),
              filled: true,
              fillColor: Colors.white,
              focusColor: Colors.white,
              errorBorder: OutlineInputBorder( borderSide: BorderSide(
                  color: Colors.red,
                ),)
            ),
            
            textAlign: TextAlign.start,
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).phoneNumber;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
