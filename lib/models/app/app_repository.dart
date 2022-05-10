import 'package:elnaamy_group/models/app/app_entity.dart';
import 'package:elnaamy_group/models/app/app_storage.dart';
import 'package:elnaamy_group/models/auth/user_entity.dart';

class AppRepository {
  final KeyValueStorage store;
  

  AppRepository(this.store);
  UserEntity loadUser() {
    return store.getUser();
  }

  AppData loadAppData() {
    return store.getAppData();
  }

 
}
