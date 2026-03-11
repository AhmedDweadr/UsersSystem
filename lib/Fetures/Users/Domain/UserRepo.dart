import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Users/Domain/Entity.dart';
import 'package:my_app/core/error/Failure.dart';

abstract class Userrepo {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, void>> addUser(  {required String name, required String address, required String phone,required List<String> content});
  Future<Either<Failure, void>> deleteUser(String user_id);
  


}
