
import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Users/Domain/UserRepo.dart';
import 'package:my_app/core/error/Failure.dart';

class DeleteuserUsecase {
  final Userrepo userrepo;

 DeleteuserUsecase({required this.userrepo});

  Future<Either<Failure, void>> call(String user_id) async {
    return await userrepo.deleteUser(user_id);
  }

}
