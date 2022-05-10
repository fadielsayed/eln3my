import 'package:elnaamy_group/component/email_field.dart';
import 'package:elnaamy_group/component/password.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/auth/forget_passowrd/forget_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ResetPassowrdActivate extends StatelessWidget {
  final String pinCode;

  ResetPassowrdActivate({Key key, this.pinCode}) : super(key: key);
  final TextEditingController _pinCode = TextEditingController();
 final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgetPasswordProvider(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xff696b9e),
          elevation: 0.0,
          title: Text(AppLocalizations.of(context).resetPasswordActivate),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 150),
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                           AppLocalizations.of(context).weWillSendCodeYouremail,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        EmailField(
                          textUp: AppLocalizations.of(context).pinCode,
                          hintText: "Pin Code",
                          controller: _pinCode,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PasswordField(
                          textUp:  AppLocalizations.of(context).newPassword,
                          hintText: AppLocalizations.of(context).newPassword,
                          controller: _password,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        PasswordField(
                          textUp: AppLocalizations.of(context).confirmNewPassword,
                          hintText:AppLocalizations.of(context).confirmNewPassword,
                          controller: _confirmassword,
                        ),

                        // Button(
                        //   text: "Send",
                        //   gradient: LinearGradient(
                        //       begin: Alignment.centerLeft,
                        //       end: Alignment.centerRight,
                        //       colors: [
                        //         Theme.of(context).accentColor,
                        //         Theme.of(context).accentColor
                        //       ]),
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Center(
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/baneer-menu.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Consumer<ForgetPasswordProvider>(
          builder: (context, forgetPasswordProvider, child) =>
              forgetPasswordProvider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          if (_pinCode.text == pinCode) {
                            forgetPasswordProvider.newPassowrd(_pinCode.text,
                                _password.text, _confirmassword.text, context);
                          } else {
                            Toast.show(AppLocalizations.of(context).invalidCode, context,
                                duration: 5, gravity: Toast.BOTTOM);
                          }
                        },
                        child: Text(
                         AppLocalizations.of(context).save,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
