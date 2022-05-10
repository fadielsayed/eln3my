import 'package:elnaamy_group/locale/localizations.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {this.fieldKey,
      this.helperText,
      this.labelText,
      this.hintText,
      this.onFieldSubmitted,
      this.onSave,
      this.controller,
      this.onChange,
      this.textUp = ""});
  final String textUp;

  final fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSave;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  final Function onChange;
  @override
  State<StatefulWidget> createState() {
    return _PasswordField();
  }
}

class _PasswordField extends State<PasswordField> {
  bool _obsecureText = true;

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
            style: TextStyle(height: .4, color: Colors.black),

            key: widget.fieldKey,
            obscureText: _obsecureText,
            controller: widget.controller,
            // maxLength: 13,
            onSaved: widget.onSave,
            onChanged: widget.onChange,
            // autovalidate: true,
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).vldpasswordrequired;
              }
              if (value.length < 2) {
                return AppLocalizations.of(context).vldpasswordlength;
              }
              return null;
            },
            onFieldSubmitted: widget.onFieldSubmitted,

            decoration: new InputDecoration(
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.black26,
                //   ),
                // ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black26,
                  ),
                ),
                hintText: widget.hintText,
                labelText: widget.labelText,
                helperText: widget.helperText,
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                // focusedBorder:
                //     OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: new GestureDetector(
                  onTap: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                  child: new Icon(
                    _obsecureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black54,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
