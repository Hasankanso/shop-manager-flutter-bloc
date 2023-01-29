class PaginationParams {
  final int page;
  final int perPage;

  PaginationParams({
    this.page = 1,
    this.perPage = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
    };
  }
}
