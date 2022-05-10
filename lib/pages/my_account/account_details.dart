import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    var userName = (token == null || token == "")
        ? "Gest"
        : Provider.of<AppStateModel>(context).userEntity.displayName;
    var email = (token == null || token == "")
        ? ""
        : Provider.of<AppStateModel>(context).userEntity.email;
         var phone = (token == null || token == "")
        ? ""
        : Provider.of<AppStateModel>(context).userEntity.phone;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).accountDeatails),
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
                // width: 300,
                // height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[350],
                ),
                child: FlatButton(
                  child: Text(
                    AppLocalizations.of(context).welcomTo + " $userName",
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
              _textWithTextField(
                  textUP: AppLocalizations.of(context).firstName),
              _textWithTextField(textUP: AppLocalizations.of(context).lastName),
              _textWithTextField(textUP: AppLocalizations.of(context).userName,
              hintText: userName),
              _textWithTextField(
                  textUP: AppLocalizations.of(context).email,
                  hintText: email),
              _textWithTextField(textUP: AppLocalizations.of(context).password),
              _textWithTextField(
                  textUP: AppLocalizations.of(context).newPassword),
              _textWithTextField(
                  textUP: AppLocalizations.of(context).repeatPassword),
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
                      AppLocalizations.of(context).save,
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

  Widget _textWithTextField(
      {String textUP,
      TextInputType keyboardType,
      String hintText,
      String labelText,
      String helperText,
      FormFieldSetter<String> onSave,
      ValueChanged<String> onFieldSubmitted,
      TextEditingController controller,
      String initialValue}) {
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
          initialValue: initialValue,
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
              return 'Please enter field';
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
