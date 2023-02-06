import 'package:equatable/equatable.dart';
import 'package:shop_manager/domain/sell/entities/sell.dart';
import 'package:shop_manager/domain/users/entities/user.dart';
import 'package:shop_manager/presentations/tables/states/table_state.dart';

enum SellPageStatus { initial, loading, loaded, error }

///states of user modules (get all users create a user etc.)
class SellState extends TableState implements Equatable {
  final List<Sell> items;
  final User? currentItem;
  final SellPageStatus status;
  final String? errorMessage;
  final int usersAbsoluteCount;

  const SellState(
      {this.currentItem,
      this.errorMessage,
      this.items = const [],
      page = 1,
      pageSize = 10,
      this.status = SellPageStatus.initial,
      this.usersAbsoluteCount = 0})
      : super(page: page, pageSize: pageSize);

  SellState copyWith(
      {User? currentItem,
      List<Sell>? items,
      int? page,
      int? pageSize,
      bool? isLoading,
      SellPageStatus? status,
      String? errorMessage,
      int? usersAbsoluteCount}) {
    return SellState(
        currentItem: currentItem ?? this.currentItem,
        items: items ?? this.items,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        usersAbsoluteCount: usersAbsoluteCount ?? this.usersAbsoluteCount);
  }

  @override
  List<Object?> get props =>
      [status, currentItem, page, pageSize, errorMessage, ...items];
}
