import 'package:dartz/dartz.dart';
import 'package:my_app/Fetures/Users/DataLayer/RemoteDataSource.dart';
import 'package:my_app/Fetures/Users/DataLayer/UserModel.dart';

import 'package:my_app/Fetures/Users/Domain/Entity.dart';
import 'package:my_app/Fetures/Users/Domain/UserRepo.dart';
import 'package:my_app/core/error/APIException.dart';
import 'package:my_app/core/error/Failure.dart';

class UserRepoImpl implements Userrepo {
  final UserDataSource userDataSource;

  UserRepoImpl({required this.userDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final result = await userDataSource.getAllUsers();

      final res=  result.map((e) => Usermodel.fromJson(e)).toList();

    //  final users = res.map((e) => e.toEntity()).toList();

      return Right(res);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.StutusCode));
    } catch (e) {
      return Left(ApiFailure(message: "Unexpected Error", statusCode: 500));
    }
  }

@override
Future<Either<Failure, void>> addUser({
  required String name,
  required String address,
  required String phone,
  required List<String> content,
}) async {
  try {
    final user = Usermodel(
      name: name,
      address: address,
      phone: phone,
      Content: content,
      CreateAt: DateTime.now().toString(),
      id: "",
    );

    // ✅ حاول تضيف المستخدم
    await userDataSource.addUser(user);

    return Right(null);
  } on ApiException catch (e) {
    // لو الـ DataSource رمى ApiException (مثلاً المستخدم موجود)
    
    return Left(ApiFailure(message: e.message, statusCode: e.StutusCode));
  } catch (e) {
    // أي خطأ عام
    return Left(ApiFailure(message: "حدث خطأ أثناء الإضافة", statusCode: 500));
  }
}






  @override
  Future<Either<Failure, void>> deleteUser(String user_id) async {
    try{
  await userDataSource.delete_user(user_id);
  return Right(null);
  }

  catch(e){
  return Left(ApiFailure(message: "Error", statusCode: 500));
  }
  }


  

}
