import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/utils/env.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatelessWidget {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _ziCode = TextEditingController();
  final TextEditingController _destination = TextEditingController();
  final TextEditingController _region = TextEditingController();
  final TextEditingController _address = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addAddress),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _textWithTextField(
                    hintText: AppLocalizations.of(context).firstName, controller: _firstName),
                _textWithTextField(
                    hintText: AppLocalizations.of(context).lastName, controller: _lastName),
                _textWithTextField(hintText: AppLocalizations.of(context).zipCode, controller: _ziCode),
                _textWithTextField(
                    hintText:  AppLocalizations.of(context).destination, controller: _destination),
                _textWithTextField(hintText: AppLocalizations.of(context).region, controller: _region),
                _textWithTextField(hintText: AppLocalizations.of(context).address, controller: _address),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<AddressProvider>(
                    builder: (context, addressProvider, child) => RaisedButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        AppLocalizations.of(context).saveNow,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          addressProvider.addAddress(
                            context: context,
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            ziCode: _ziCode.text,
                            destination: _destination.text,
                            region: _region.text,
                            address: _address.text,
                            cityId: 1,
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
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
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter Text';
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
