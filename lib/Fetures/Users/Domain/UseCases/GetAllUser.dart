import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Users/Domain/Entity.dart';
import 'package:my_app/Fetures/Users/Domain/UserRepo.dart';
import 'package:my_app/core/error/Failure.dart';

class GetalluseruserCase {
  final Userrepo userrepo;

  GetalluseruserCase({required this.userrepo});

  Future<Either<Failure, List<UserEntity>>> call() async {
    return await userrepo.getAllUsers();
  }
}
