import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/DI/injection.dart';
import 'package:shop_manager/data/data_infra/interfaces/db_interface.dart';
import 'package:shop_manager/data/data_infra/tables_creator.dart';
import 'package:shop_manager/domain/app_settings/app_settings_interface.dart';
import 'package:shop_manager/presentations/app_settings/blocs/bloc.dart';
import 'package:shop_manager/presentations/app_settings/states/app_setting_state.dart';
import 'package:shop_manager/presentations/start_menu.dart';
import 'package:shop_manager/presentations/auth/blocs/auth_bloc.dart';

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
    MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingBloc>(
          create: (BuildContext context) =>
              AppSettingBloc(GetIt.instance)..initialize(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              AuthBloc(GetIt.instance, context.read<AppSettingBloc>())
                ..initialize(),
        ),
      ],
      child: MyApp(db),
    ),
  );
}

class MyApp extends StatelessWidget {
  final DBInterface db;
  const MyApp(this.db, {super.key});

  @override
  Widget build(BuildContext context) {
    AppSettingBloc appSettingsWatcher = context.watch<AppSettingBloc>();
    AppSettingBloc appSettingsReader = context.read<AppSettingBloc>();
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    switch (appSettingsWatcher.state.status) {
      case AppSettingStatus.loading:
      case AppSettingStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case AppSettingStatus.error:
        return Center(child: Text(context.read<AppSettingBloc>().state.error!));
      case AppSettingStatus.success:
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
          locale: appSettingsReader.state.language,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const StartMenu(),
        );
    }
  }
}
