import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/tables_creator.dart';
import 'package:shop_manager/repository/MySQLDB.dart';
import 'package:shop_manager/repository/user_repo.dart';
import 'package:shop_manager/providers/user_controller.dart';
import 'package:shop_manager/views/start_menu.dart';
import 'repository/interfaces/db_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = await rootBundle.loadString("lib/config.json");
  final configJS = jsonDecode(config)["db"];

  DBInterface db = MySQLDB();
  await db.connect(configJS["host"], configJS["port"], configJS["username"],
      configJS["password"], configJS["name"]);

  CreateTables createTables = CreateTables(db: db);
  await createTables.createAll();
  runApp(
    BlocProvider(
      create: (_) => UserController(UserRepository(db: db)),
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
      home: StartMenu(db: db),
    );
  }
}
