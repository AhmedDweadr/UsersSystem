import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/Fetures/Users/Domain/UseCases/AddUser.dart';
import 'package:my_app/Fetures/Users/Domain/UseCases/DeleteUser.dart';
import 'package:my_app/Fetures/Users/Domain/UseCases/GetAllUser.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/GetContentUsecase.dart';

import 'package:my_app/Fetures/Users/Presentation/UserCubit/State.dart';

import 'package:my_app/core/servece/userparams.dart';

class userCubit extends Cubit<UserState> {
  userCubit({
    required this.getalluseruserCase,
    required this.adduserUserCase,
    required this.deleteuserUsecase,

    required this.getcontentusecase,
  }) : super(InitialState()); // ✅

  final GetalluseruserCase getalluseruserCase;
  final AddUserUseCase adduserUserCase;
  final DeleteuserUsecase deleteuserUsecase;

  final Getcontentusecase getcontentusecase;

  Future<void> getAllUsers() async {
    emit(LoadingState());

    final result = await getalluseruserCase();

    result.fold(
      (f) {
        emit(userError(Message: f.message));
      },
      (data) {
        emit(GetUserState(userData: data));
      },
    );
  }

  Future<void> addUser({
    required String name,
    required String address,
    required String phone,
    required List<String> content,
  }) async {
    emit(LoadingState());

    final result = await adduserUserCase(
      Userparams(name: name, address: address, phone: phone, content: content),
    );

    result.fold((failure) => emit(userError(Message: failure.message)), (
      _,
    ) async {
      emit(userAddedSuccess(message: "تم اضافه user"));
    });
  }

  Future<void> delete_User({required String user_id}) async {
    emit(LoadingState());

    final result = await deleteuserUsecase(user_id);

    result.fold((failure) => emit(userError(Message: failure.message)), (
      _,
    ) async {
      await getAllUsers();
    });
  }
}
