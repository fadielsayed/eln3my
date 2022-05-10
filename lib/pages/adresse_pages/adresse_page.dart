import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address_provider.dart';
import 'package:elnaamy_group/pages/adresse_pages/my_address_json.dart';
import 'package:elnaamy_group/pages/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './edite_address.dart';

class AdressePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var token =
        Provider.of<AppStateModel>(context, listen: false).appData.token;
    var userName = (token == null || token == "")
        ? "name"
        : Provider.of<AppStateModel>(context).userEntity.displayName;

    return (token == null || token == "")
        ? Scaffold(
            appBar: AppBar(title: Text(AppLocalizations.of(context).address)),
            body: Center(
                child: FlatButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => LoginPage())),
              child: Text(AppLocalizations.of(context).youShouldLogIn),
            )),
          )
        : Consumer<AddressProvider>(
            builder: (context, addressProvider, child) => FutureBuilder(
              future: addressProvider.loadAllAddress(context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  if (snapshot.error == "No Address" ||
                      snapshot.error == "لايوجد عنوان") {
                    return Scaffold(
                      appBar: AppBar(
                          title: Text(AppLocalizations.of(context).address)),
                      body: Center(
                        child: Column(
                          children: <Widget>[
                            Text(AppLocalizations.of(context)
                                .noAddressGoToAddAddress),
                            FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => AddAddress()));
                                },
                                child: Text(
                                    AppLocalizations.of(context).addAddress))
                          ],
                        ),
                      ),
                    );
                  }
                  // return Scaffold(
                  //     body: Center(
                  //   child: Text(snapshot.error),
                  // ));
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == null) {
                  return Scaffold(
                      body: Center(
                    child: Text("no Data"),
                  ));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                      body: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(AppLocalizations.of(context).addAddress),
                    backgroundColor: Color(0xff00577d),
                  ),
                  body: Container(
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
                              AppLocalizations.of(context).welcomTo +
                                  "$userName",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                MyAddress myAddress = snapshot.data[i];
                                return Column(
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                      ),
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.location_on,
                                          size: 35,
                                          color: Theme.of(context).accentColor,
                                        ),
                                        title: Text(
                                            "${myAddress.region} - ${myAddress.destination} "),
                                        subtitle: Text(
                                            "${myAddress.address} - ${myAddress.zipCode}"),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            IconButton(
                                                icon: Icon(Icons.edit),
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              EditeAddress(
                                                                id: myAddress
                                                                    .id,
                                                                firstName:
                                                                    myAddress
                                                                        .firstName,
                                                                lastname:
                                                                    myAddress
                                                                        .lastName,
                                                                zipCode:
                                                                    myAddress
                                                                        .zipCode,
                                                                destination:
                                                                    myAddress
                                                                        .destination,
                                                                region:
                                                                    myAddress
                                                                        .region,
                                                                address:
                                                                    myAddress
                                                                        .address,
                                                              )));
                                                }),
                                            IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: null)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => AddAddress()));
                    },
                    child: Icon(Icons.add),
                  ),
                );
              },
            ),
          );
  }
}
