class ApiResponse {
  Object? data;
  int? totalCount;
  bool isSuccessful;
  int? statusCode;
  String? successMessage;
  String? errorMessage;
  Object? pagination;
  ApiResponse({
    this.data,
    this.totalCount,
    required this.isSuccessful,
    this.statusCode,
    this.successMessage,
    this.errorMessage,
    this.pagination,
  });

  @override
  String toString() {
    return 'ApiResponse(results: $data, pagination: $pagination, totalCount: $totalCount, isSuccessful: $isSuccessful, statusCode: $statusCode, successMessage: $successMessage, errorMessage: $errorMessage)';
  }
}
