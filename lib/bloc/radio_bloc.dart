import 'package:flutter_bloc/flutter_bloc.dart';

class RadioCubit extends Cubit<GenderOption> {
  RadioCubit(GenderOption initialOption) : super(initialOption);
  void changeOption(GenderOption option) {
    emit(option);
  }
}

enum GenderOption {
  male,
  female;
}
