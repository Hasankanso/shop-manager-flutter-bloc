import 'package:shop_manager/domain/common_params/pagination_params.dart';

class GetAllParams extends PaginationParams {
  GetAllParams({required int page, int pageSize = 10})
      : super(page: page, perPage: pageSize);
}
