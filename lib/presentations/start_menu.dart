import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/domain/users/usecases/create_user_case.dart';
import 'package:shop_manager/domain/users/usecases/get_all_users_case.dart';
import 'package:shop_manager/presentations/persons/views/show_user_list.dart';
import 'package:shop_manager/presentations/users/blocs/user_bloc.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    var getit = GetIt.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Menu'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                  create: (context) => UserBloc(getit.get<CreateUserCase>(),
                      getit.get<GetAllUsersCase>()),
                  child: const ShowUserList());
            }));
          },
          child: Text('Users'.i18n()),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Products'.i18n()),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/orders');
          },
          child: Text('Orders'.i18n()),
        ),
      ]),
    );
  }
}
