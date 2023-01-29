import 'package:shop_manager/domain/common_params/pagination_params.dart';

class GetAllUsersParams extends PaginationParams {
  GetAllUsersParams({required int page, int pageSize = 10})
      : super(page: page, perPage: pageSize);
}
