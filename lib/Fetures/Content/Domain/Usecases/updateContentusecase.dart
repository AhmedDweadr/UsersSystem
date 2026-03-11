import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Content/Domain/ContentRepo.dart';
import 'package:my_app/core/error/Failure.dart';

class Updatecontentusecase {
  final Contentrepo contentrepo;

  Updatecontentusecase({required this.contentrepo});



  Future<Either<Failure, void>> call(String Content,int user_id) async {
    return await contentrepo.updateContent(Content,user_id);
  }
}