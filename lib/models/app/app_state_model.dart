import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_entity.dart';
import 'package:elnaamy_group/models/auth/user_entity.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'app_repository.dart';

class AppStateModel with ChangeNotifier {
  final AppRepository repository;

  AppState _state = AppState.uninitialized;
  AppState get state => _state;
  set state(AppState state) {
    _state = state;
    notifyListeners();
  }

  AppData get appData => repository.loadAppData();
  UserEntity get userEntity => repository.loadUser();

  AppStateModel({
    @required this.repository,
  });

  SpecificLocalizationDelegate _specificLocalizationDelegate =
      new SpecificLocalizationDelegate(Locale(ui.window.locale.languageCode));
  SpecificLocalizationDelegate get specificLocalizationDelegate =>
      _specificLocalizationDelegate;

  int _selectedBranch;
  int get selectedBranch => _selectedBranch == null
      ? repository.store.getSelectedBranch()
      : _selectedBranch;
  void branchselect(int branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  List branchesList;
  void load() async {}
  void authenticate(
    AppData data,
    UserEntity entity,
  ) async {
    await repository.store.setAppData(data);
    await repository.store.setUser(entity);
  }

  void unauthenticate() async {
    await repository.store.setAppData(null);
    await repository.store.setUser(null);
  }

  void notactivate(
    AppData data,
    UserEntity entity,
  ) async {
    // set in the storage ..
    await repository.store.setAppData(data);
    await repository.store.setUser(entity);
  }

  Future onLocaleChange(Locale locale) async {
    _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    AppData data = repository.loadAppData();

    data.compyWith(langCode: locale.languageCode);
    await repository.store.setAppData(data);
    notifyListeners();
  }


}
