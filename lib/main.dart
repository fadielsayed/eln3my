import 'package:elnaamy_group/models/app/app_repository.dart';
import 'package:elnaamy_group/models/app/app_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/app/app_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ElNaamyApp(
    repository:
        AppRepository( 
          KeyValueStorage(
          await SharedPreferences.getInstance(),
        )),
  ));
}
