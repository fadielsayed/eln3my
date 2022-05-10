import 'package:elnaamy_group/locale/localizations.dart';
import 'package:elnaamy_group/models/app/app_repository.dart';
import 'package:elnaamy_group/models/app/app_state_model.dart';
import 'package:elnaamy_group/models/app/app_theme.dart';
import 'package:elnaamy_group/models/providers/products.dart';
import 'package:elnaamy_group/models/providers/services.dart';
import 'package:elnaamy_group/pages/adresse_pages/add_address_provider.dart';

import 'package:elnaamy_group/pages/cart_screen/cart.dart';
import 'package:elnaamy_group/pages/drawer_items/setting_load_data.dart';
import 'package:elnaamy_group/pages/home/home_main.dart';
import 'package:elnaamy_group/pages/my_orders/order_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ElNaamyApp extends StatelessWidget {
  final AppRepository repository;

  const ElNaamyApp({Key key, @required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppStateModel(repository: repository),
        ),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider(create: (_) => Servics()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => SettingLoadData()..loadGeneralSetting(context)),
      ],
      child: Selector<AppStateModel, SpecificLocalizationDelegate>(
          selector: (_, model) => model.specificLocalizationDelegate,
          builder: (context, specificLocalizationDelegate, _) {
            return MaterialApp(
                theme: ElNaamyAppTheme.theme,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                  specificLocalizationDelegate
                ],
                supportedLocales: [Locale('en'), Locale('ar')],
                locale: specificLocalizationDelegate.overriddenLocale,
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context).appTitle,
                routes: {
                  // put our new route here ...
                  // '/': (context) => currentPage,
                },
                home: HomeMain());
          }),
    );
  }
}
