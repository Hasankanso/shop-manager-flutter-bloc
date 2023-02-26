import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/DI/injection.dart';
import 'package:shop_manager/data/data_infra/tables_creator.dart';
import 'package:shop_manager/data/users/user_repo.dart';
import 'package:shop_manager/presentations/start_menu.dart';
import 'package:shop_manager/presentations/auth/auth_bloc.dart';
import 'data/data_infra/interfaces/db_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DI().initialize();

  final config = await rootBundle.loadString("lib/config.json");
  final configJS = jsonDecode(config)["db"];

  var db = GetIt.instance.get<DBInterface>();

  await db.connect(configJS["host"], configJS["port"], configJS["username"],
      configJS["password"], configJS["name"]);

  CreateTables createTables = CreateTables(db: db);
  await createTables.createAll();

  runApp(
    BlocProvider(
      create: (_) => AuthBloc(UserRepository(db: db)),
      child: MyApp(db),
    ),
  );
}

class MyApp extends StatelessWidget {
  final DBInterface db;
  const MyApp(this.db, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // delegate from localization package.
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'AR'),
      ],
      locale: const Locale("ar", "AR"),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartMenu(),
    );
  }
}
