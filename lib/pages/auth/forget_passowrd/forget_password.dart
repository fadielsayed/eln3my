import 'package:elnaamy_group/component/email_field.dart';
import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/pages/auth/forget_passowrd/forget_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ForgetPasswordProvider(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xff696b9e),
          elevation: 0.0,
          title: Text( AppLocalizations.of(context).resetPasswordAppBar),
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
                             AppLocalizations.of(context).sendCode,
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
                          textUp:  AppLocalizations.of(context).email,
                          hintText:  AppLocalizations.of(context).email,
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
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
                          if (_formKey.currentState.validate()) {
                            forgetPasswordProvider.resetPassword(
                                _email.text, context);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context).send,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
