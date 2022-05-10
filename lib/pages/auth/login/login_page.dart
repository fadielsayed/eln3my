import 'package:elnaamy_group/component/button.dart';
import 'package:elnaamy_group/component/email_field.dart';
import 'package:elnaamy_group/component/language_dialog.dart';
import 'package:elnaamy_group/component/password.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/auth/forget_passowrd/forget_password.dart';
import 'package:elnaamy_group/pages/auth/login/login_provider.dart';
import 'package:elnaamy_group/pages/auth/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var currentLocal = Localizations.localeOf(context).languageCode;

    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xff696b9e),
          elevation: 0.0,
          title: Text(AppLocalizations.of(context).login),
          centerTitle: true,
          leading: FlatButton(
            onPressed: () => Provider.of<AppStateModel>(context,listen: false)
                .onLocaleChange(Locale(currentLocal == "en" ? "ar" : "en")),
            child: Text(currentLocal == "en" ? "ع" : "En"),
          ),
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
                          height: 40,
                        ),
                        // Text(
                        //   "User Name",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 16,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        EmailField(
                          textUp: AppLocalizations.of(context).userName,
                          keyboardType: TextInputType.emailAddress,
                          controller: _name,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        PasswordField(
                          textUp: AppLocalizations.of(context).password,
                          controller: _password,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPassword(),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context).resetPaasword,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Consumer<LoginProvider>(
                          builder: (context, loginProvider, child) =>
                              loginProvider.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Button(
                                      text:  AppLocalizations.of(context).login,
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Theme.of(context).accentColor,
                                            Theme.of(context).accentColor
                                          ]),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          loginProvider.login(_name.text,
                                              _password.text, context);
                                        }
                                      }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Button(
                          text: AppLocalizations.of(context).signUp,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xff143240), Color(0xff143240)]),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
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
      ),
    );
  }
}
