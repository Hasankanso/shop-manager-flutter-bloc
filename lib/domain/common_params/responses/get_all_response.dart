class GetAllResponse<T> {
  final List<T> items;
  final int absoluteCount;

  GetAllResponse(this.items, this.absoluteCount);
}
