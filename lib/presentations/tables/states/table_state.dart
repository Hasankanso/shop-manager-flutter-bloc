import 'package:equatable/equatable.dart';

class TableState extends Equatable {
  final int page;
  final int pageSize;
  const TableState({this.page = 1, this.pageSize = 10});

  @override
  List<Object?> get props => [page, pageSize];
}
