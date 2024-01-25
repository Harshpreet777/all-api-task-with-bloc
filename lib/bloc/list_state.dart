import 'package:bloc_api_task/models/response_model.dart';

abstract class ListState {}

class InitialState extends ListState {}

class LoadingState extends ListState {}

class ErrorState extends ListState {
  final String message;
  ErrorState(this.message);
}

class ResponseState extends ListState {
  final List<ResponseModel> lists;
  ResponseState(this.lists);
}
