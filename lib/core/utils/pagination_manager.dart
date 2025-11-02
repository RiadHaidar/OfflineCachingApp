class PaginationManager<T> {
  int currentPage = 1;
  List<T> items = [];
  bool hasMore = true;
  bool isLoadingMore = false;
  int? totalPages;

  void reset() {
    currentPage = 1;
    items = [];
    hasMore = true;
    isLoadingMore = false;
    totalPages = null;
  }

  void updateWithNewPage({
    required List<T> data,
    required int page,
    required int? total,
    bool isRefresh = false,
  }) {
    if (isRefresh) {
      items = data;
      currentPage = 1;
    } else {
      items = [...items, ...data];
      currentPage = page;
    }

    totalPages = total;
    hasMore = total != null ? page < total : data.isNotEmpty;
    isLoadingMore = false;
  }

  bool get canLoadMore => hasMore && !isLoadingMore;
}
