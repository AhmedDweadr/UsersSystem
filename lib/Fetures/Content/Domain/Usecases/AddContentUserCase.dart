import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Content/Domain/ContentRepo.dart';
import 'package:my_app/core/error/Failure.dart';

class Addcontentusercase {
  final Contentrepo contentrepo;

  Addcontentusercase({required this.contentrepo});



  Future<Either<Failure, void>> call(String Content,String user_id) async {
    return await contentrepo.AddContent(user_id,Content);
  }
}