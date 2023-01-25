import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:shop_manager/providers/user_module/user_state_provider.dart';
import 'package:shop_manager/repository/interfaces/db_interface.dart';
import 'package:shop_manager/repository/user_repo.dart';
import 'package:shop_manager/views/add_items/add_customer_view.dart';
import 'package:shop_manager/views/add_items/add_product_view.dart';
import 'package:shop_manager/views/add_items/add_supplier_view.dart';
import 'package:shop_manager/views/add_items/add_user_view.dart';
import 'package:shop_manager/views/show_items/show_user_list.dart';

class StartMenu extends StatelessWidget {
  final DBInterface db;
  const StartMenu({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(crossAxisCount: 4, children: [
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserView()),
          ),
          child: Text("Create a new User".i18n()),
        ),
        ElevatedButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddSupplierView()),
                ),
            child: Text("Create a new Supplier".i18n())),
        ElevatedButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddCustomerView()),
                ),
            child: Text("Create a new Customer".i18n())),
        ElevatedButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProductView()),
                ),
            child: Text("Create a new Product".i18n())),
        ElevatedButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (_) =>
                                UserStateProvider(UserRepository(db: db))
                                  ..getUsers(),
                            child: const ShowUserList(),
                          )),
                ),
            child: Text("Show Users".i18n())),
      ]),
    );
  }
}
