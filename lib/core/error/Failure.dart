abstract class Failure {
  final String message;
  final int statusCode;

  Failure({required this.message, required this.statusCode});

}


class ApiFailure extends Failure{
  ApiFailure({required super.message,  required super.statusCode });
  
}