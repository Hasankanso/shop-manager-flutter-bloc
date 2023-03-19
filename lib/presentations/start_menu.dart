import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/presentations/app_settings/blocs/bloc.dart';
import 'package:shop_manager/presentations/auth/states/auth_state.dart';
import 'package:shop_manager/presentations/auth/views/create_account_form.dart';
import 'package:shop_manager/presentations/auth/views/login_form.dart';
import 'package:shop_manager/presentations/products/blocs/product_bloc.dart';
import 'package:shop_manager/presentations/products/views/show_product_list.dart';
import 'package:shop_manager/presentations/sales/blocs/sale_bloc.dart';
import 'package:shop_manager/presentations/sales/views/show_sales.dart';
import 'package:shop_manager/presentations/auth/blocs/auth_bloc.dart';
import 'package:shop_manager/presentations/users/views/show_user_list.dart';
import 'package:shop_manager/presentations/users/blocs/user_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var getit = GetIt.instance;

    AuthBloc authBloc = context.watch<AuthBloc>();

    Widget body;

    switch (authBloc.state.status) {
      case AuthStatus.initial:
        body = LoginForm();
        break;
      case AuthStatus.noUsers:
        body = CreateAccountForm();
        break;
      case AuthStatus.error:
        String error = (authBloc.state.error ?? "error").i18n();
        body = Center(child: Text(error));
        break;
      case AuthStatus.authenticated:
        body = Column(
          children: [
            Expanded(
              child: Text('Welcome '.i18n() +
                  (authBloc.state.loggedUser?.fullName() ?? "error")),
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " ${DateFormat('yyyy-MM-dd').format(DateTime.now())} ",
                      textDirection: ui.TextDirection.ltr,
                    ),
                    Text(DateFormat(
                            'EEEE',
                            context
                                    .read<AppSettingBloc>()
                                    .state
                                    .language
                                    ?.languageCode ??
                                'en')
                        .format(DateTime.now())),
                  ],
                ),
                Text(
                    textDirection: ui.TextDirection.ltr,
                    DateFormat('hh:mm a').format(DateTime.now())),
              ],
            )),
            Expanded(
              flex: 8,
              child: GridView.count(
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 50,
                  padding: const EdgeInsets.all(20),
                  crossAxisCount: 3,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                              create: (context) => UserBloc(getit)..getUsers(),
                              child: const ShowUserList());
                        }));
                      },
                      child: Text('Users'.i18n()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider(
                              create: (context) => SaleBloc(getit)..get(),
                              child: const ShowSaleList());
                        }));
                      },
                      child: Text('Sales'.i18n()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return BlocProvider(
                              create: (_) =>
                                  ProductBloc(getit, context.read<AuthBloc>())
                                    ..getProducts(),
                              child: const ShowProductList());
                        }));
                      },
                      child: Text('Show Products'.i18n()),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/orders');
                      },
                      child: Text('Orders'.i18n()),
                    ),
                  ]),
            ),
          ],
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Start Menu'.i18n()),
      ),
      body: body,
    );
  }
}
