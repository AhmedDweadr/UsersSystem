import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Content/Domain/ContnetEntity.dart';

import 'package:my_app/core/error/Failure.dart';

abstract class Contentrepo {
  Future<Either<Failure, List<ContentEntity>>> GetContent(String user_id);

  Future<Either<Failure, void>> AddContent(String Content, String user_id);

  Future<Either<Failure, void>> updateContent(String contentId, int content);

  Future<Either<Failure, void>> deleteContent(int contentId);
}
