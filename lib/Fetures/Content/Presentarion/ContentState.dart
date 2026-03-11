import 'package:my_app/Fetures/Content/Domain/ContnetEntity.dart';

abstract class ContentState {}

class InitialState extends ContentState{}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final List<ContentEntity> content;

  ContentLoaded({required this.content});

}


class Contenterror extends ContentState {
  final String message;

  Contenterror({required this.message});



}