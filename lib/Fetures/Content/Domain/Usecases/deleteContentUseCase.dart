import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Content/Domain/ContentRepo.dart';
import 'package:my_app/core/error/Failure.dart';

class Deletecontentusecase {
  final Contentrepo contentrepo;

  Deletecontentusecase({required this.contentrepo});



  Future<Either<Failure, void>> call(int ContentId) async {
    return await contentrepo.deleteContent(ContentId);
  }
}