import 'package:my_app/Fetures/Users/Domain/Entity.dart';

abstract class UserState {}

class InitialState extends UserState {}

class LoadingState extends UserState {}

class userAddedSuccess extends UserState {
 final String message;

  userAddedSuccess({required this.message});

}

class GetUserState extends UserState {
  final List<UserEntity> userData;

  GetUserState({required this.userData});
}

class GetContentState extends UserState {
  final List<Map<String, dynamic>> content;

  GetContentState({required this.content});
}

class userError extends UserState {
  final String Message;

  userError({required this.Message});
}
