import 'package:flutter/material.dart';

class UpdateUser extends StatelessWidget {
  final bool isNew;

  const UpdateUser({Key key, this.isNew = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("update User "),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Update"),
          )
        ],
      ),
    );
  }
}
