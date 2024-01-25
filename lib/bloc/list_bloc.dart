import 'package:bloc_api_task/bloc/list_state.dart';
import 'package:bloc_api_task/services/http_get_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListCubit extends Cubit<ListState> {
  final HttpGetApiService _listRepository;

  ListCubit(this._listRepository) : super(InitialState());
  Future<void> fetchList() async {
    emit(LoadingState());
    try {
      final response = await _listRepository.getData();
      emit(ResponseState(response));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
