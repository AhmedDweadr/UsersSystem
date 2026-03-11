import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_app/Fetures/Content/Domain/Usecases/AddContentUserCase.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/GetContentUsecase.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/deleteContentUseCase.dart';
import 'package:my_app/Fetures/Content/Domain/Usecases/updateContentusecase.dart';
import 'package:my_app/Fetures/Content/Presentarion/ContentState.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit({
    required this.getcontentusecase,
    required this.addcontentusercase,
    required this.updatecontentusecase,
    required this.deletecontentusecase,
  }) : super(InitialState()); // ✅

  final Getcontentusecase getcontentusecase;

  final Addcontentusercase addcontentusercase;

  final Updatecontentusecase updatecontentusecase;

  final Deletecontentusecase deletecontentusecase;

  Future<void> getContent(String userId) async {
    emit(ContentLoading());

    final result = await getcontentusecase(userId);

    return result.fold(
      (failure) {
        emit(Contenterror(message: failure.message));
      },
      (res) {
        emit(ContentLoaded(content: res));
      },
    );
  }

  Future<void> AddContent(String Content, String userId) async {
    emit(ContentLoading());

    final result = await addcontentusercase(Content, userId);

    return result.fold((failure) {
      emit(Contenterror(message: failure.message));
    }, (_) async {});
  }

  Future<void> updateContent(int contentId, String content) async {
    final res = await updatecontentusecase(content, contentId);
    return res.fold((failure) {
      emit(Contenterror(message: failure.message));
    }, (_) async {});
  }

  Future<void> deleteContent(int contentId ,String userId) async {
    final res = await deletecontentusecase (contentId ,);
    res.fold(
      (l) => emit(Contenterror(message: l.message)),
      // ignore: unnecessary_set_literal
      (_) => {

        getContent(userId)
      },
    );
  }
}
