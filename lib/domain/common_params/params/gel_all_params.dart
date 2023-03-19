import 'package:shop_manager/domain/common_params/pagination_params.dart';

class GetAllParams extends PaginationParams {
  final Map<String, dynamic>? containsFilter;
  final Map<String, dynamic>? equalFilter;

  GetAllParams(
      {int page = 1, int pageSize = 10, this.containsFilter, this.equalFilter})
      : super(page: page, perPage: pageSize);
}
