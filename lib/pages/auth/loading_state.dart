import 'package:flutter/material.dart';

class LoadingState extends StatefulWidget {
  @override
  _LoadingStateState createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {
  @override
  void initState() {
    super.initState();
  }

  void getState() {}
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Provider.of<AppStateModel>(context, listen: false).getUserType(context);
    });
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
