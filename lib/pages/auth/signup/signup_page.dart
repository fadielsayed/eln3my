import 'package:elnaamy_group/component/email_field.dart';
import 'package:elnaamy_group/component/password.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/auth/signup/signup_provider.dart';
import 'package:elnaamy_group/pages/my_orders/my_order_managment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SignUpPage extends StatelessWidget {
  final bool value = false;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPasswor = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpProvider(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xff696b9e),
          elevation: 0.0,
          title: Text(AppLocalizations.of(context).signUp),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 145),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 8,
                          ),
                          EmailField(
                            textUp: AppLocalizations.of(context).userName,
                            keyboardType: TextInputType.emailAddress,
                            controller: _name,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          EmailField(
                            textUp: AppLocalizations.of(context).email,
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          EmailField(
                            textUp: AppLocalizations.of(context).phone,
                            keyboardType: TextInputType.number,
                            controller: _phone,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          PasswordField(
                            textUp: AppLocalizations.of(context).password,
                            controller: _password,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          PasswordField(
                            textUp:
                                AppLocalizations.of(context).confirmPassword,
                            controller: _confirmPasswor,
                          ),
                          Row(
                            children: <Widget>[
                              Consumer<SignUpProvider>(
                                builder: (_, radioValue, child) => Checkbox(
                                  value: radioValue.radioValue,
                                  onChanged: (bool value) {
                                    radioValue.setRadioValue(value);
                                  },
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context).iAgreeAll,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MyOrderManagment()));
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .termsAndConditions,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Consumer<SignUpProvider>(
                            builder: (context, signupProvider, child) =>
                                signupProvider.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.94,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Color(0xff00577d),
                                          ),
                                          child: FlatButton(
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .signUp,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                if (signupProvider.radioValue ==
                                                    false) {
                                                  Toast.show(
                                                      AppLocalizations.of(
                                                              context)
                                                          .youShouldApproveTermsAndCondition,
                                                      context,
                                                      duration: 5,
                                                      gravity: Toast.BOTTOM);
                                                  return;
                                                }
                                                signupProvider.signUp(
                                                    _name.text,
                                                    _email.text,
                                                    _phone.text,
                                                    _password.text,
                                                    _confirmPasswor.text,
                                                    context);
                                              }
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) => SelectBranch(),
                                              //   ),
                                              // );
                                            },
                                          ),
                                        ),
                                      ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
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
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/baneer-menu.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: RaisedButton(
        //     color: Theme.of(context).accentColor,
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => SelectBranch(),
        //         ),
        //       );
        //     },
        //     child: Text(
        //       "Sign Up",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
