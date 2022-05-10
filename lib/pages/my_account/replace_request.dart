import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepalcementRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    var userName = (token == null || token == "")
        ? "Gest"
        : Provider.of<AppStateModel>(context).userEntity.displayName;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context).replacementrequest,
            textAlign: TextAlign.center,
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
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
                    AppLocalizations.of(context).welcomTo + "$userName",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context).replacementAndReturnPolicy,
                style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) => Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.24,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    child: Image.asset(
                                        "assets/images/logo-about.png")),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: RaisedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return _dialog(context: context);
                                          });
                                    },
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(4.0)),
                                    child: Text(
                                      AppLocalizations.of(context).reason,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Color(0xff00577d),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            ImageIcon(
                                              AssetImage(
                                                  "assets/icon/order-return.png"),
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .replaceMentAndReturn,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        AppLocalizations.of(context).dateOrder),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("12/5/2020"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("4:32"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  color: Colors.grey[300],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  child: Row(
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context)
                                          .yourOrderNum),
                                      Spacer(),
                                      Text("15445#")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Colors.grey[300],
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  child: Row(
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context)
                                          .sumOrder),
                                      Spacer(),
                                      Text("145 sr")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _dialog({BuildContext context}) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(AppLocalizations.of(context).returnProduct),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppLocalizations.of(context).reasonreturn),
            SizedBox(
              height: 5,
            ),
            TextField(
                maxLines: 2,
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
                )),
            SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xff00577e),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).send),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context).close),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
