class ApiException implements Exception {
  final String message;
  final int StutusCode;

  ApiException({required this.message, required this.StutusCode});

  @override
  String toString() {
    return "This is a APIException === ${message}";
  }
}
