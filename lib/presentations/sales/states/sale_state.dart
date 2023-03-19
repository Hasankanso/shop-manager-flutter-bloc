import 'package:equatable/equatable.dart';
import 'package:shop_manager/domain/sales/entities/sale.dart';
import 'package:shop_manager/presentations/tables/states/table_state.dart';

enum SalesPageStatus { initial, loading, loaded, error }

///states of user modules (get all users create a user etc.)
class SaleState extends TableState implements Equatable {
  final List<Sale> items;
  final Sale? currentItem;
  final SalesPageStatus status;
  final String? errorMessage;
  final int absoluteCount;
  final int? selectedIndex;

  const SaleState(
      {this.currentItem,
      this.errorMessage,
      this.selectedIndex,
      this.items = const [],
      page = 1,
      pageSize = 10,
      this.status = SalesPageStatus.initial,
      this.absoluteCount = 0})
      : super(page: page, pageSize: pageSize);

  SaleState copyWith(
      {Sale? currentItem,
      List<Sale>? items,
      int? page,
      int? pageSize,
      bool? isLoading,
      SalesPageStatus? status,
      String? errorMessage,
      int? usersAbsoluteCount}) {
    return SaleState(
        currentItem: currentItem ?? this.currentItem,
        items: items ?? this.items,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        absoluteCount: usersAbsoluteCount ?? this.absoluteCount);
  }

  @override
  List<Object?> get props =>
      [status, currentItem, page, pageSize, errorMessage, ...items];
}
