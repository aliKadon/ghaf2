class ApiResponse<T> {
  final String message;
  final int status;
  T? object;

   ApiResponse({
    required this.message,
    required this.status,
    this.object
  });
}
