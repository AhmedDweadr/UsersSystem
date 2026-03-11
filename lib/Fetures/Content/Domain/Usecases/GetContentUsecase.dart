
import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Content/Domain/ContentRepo.dart';
import 'package:my_app/Fetures/Content/Domain/ContnetEntity.dart';

import 'package:my_app/core/error/Failure.dart';

class Getcontentusecase {
  final Contentrepo contentrepo;

  Getcontentusecase({required this.contentrepo});



  Future<Either<Failure,List<ContentEntity> >> call(String user_id) async {
    return await contentrepo.GetContent(user_id);
  }

}
