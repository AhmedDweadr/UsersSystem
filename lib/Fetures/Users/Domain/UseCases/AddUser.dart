import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Users/Domain/UseCases/usecase.dart';
import 'package:my_app/Fetures/Users/Domain/UserRepo.dart';
import 'package:my_app/core/error/Failure.dart';
import 'package:my_app/core/servece/userparams.dart';

class AddUserUseCase
    implements  UseCasewithparams<Either<Failure, void>, Userparams> {

  final Userrepo repository;

  AddUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Userparams params) async {
    return await repository.addUser(
      name: params.name,
      address: params.address,
      phone: params.phone,
      content: params.content
    );
  }
}

