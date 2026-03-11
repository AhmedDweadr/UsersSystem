import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Content/Data/ContentModel.dart';
import 'package:my_app/Fetures/Content/Data/DataSource.dart';
import 'package:my_app/Fetures/Content/Domain/ContentRepo.dart';
import 'package:my_app/Fetures/Content/Domain/ContnetEntity.dart';
import 'package:my_app/core/error/Failure.dart';

class Contentrepoimpl implements Contentrepo {
  final ContentDataSource contentDataSource;

  Contentrepoimpl({required this.contentDataSource});

  @override
  Future<Either<Failure, List<ContentEntity>>> GetContent(
    String user_id,
  ) async {
    try {
      final result = await contentDataSource.GetContent(user_id);

      print("0000000000000000000000000000000000000000");
      print(result);
      print("0000000000000000000000000000000000000000");
      final res = result.map((e) => ContentModel.fromJson(e)).toList();

      print("11111111111111111111111111111111111111");
      print(res);
      print("111111111111111111111111111111111111111");
      return Right(res);
    } catch (e) {
      return Left(ApiFailure(message: "Error", statusCode: 500));
    }
  }


  Future<Either<Failure, void>> AddContent(
    String Content,
    String user_id,
  ) async {
    try {
      final res = await contentDataSource.addContent(Content, user_id);
      return Right(res);
    } catch (e) {
      return Left(ApiFailure(message: "Error", statusCode: 500));
    }
  }



  @override
  Future<Either<Failure, void>> updateContent(String contentId, int content) async {
    try {
      await contentDataSource.updateContent(contentId, content);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to update content", statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> deleteContent(int contentId) async {
    try {
      await contentDataSource.deleteContent(contentId);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: "Failed to delete content", statusCode: 500));
    }
  }

}
