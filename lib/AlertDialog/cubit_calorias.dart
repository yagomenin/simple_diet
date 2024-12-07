import 'package:flutter_bloc/flutter_bloc.dart';

class CalorieCubit extends Cubit<double> {
  CalorieCubit() : super(0.0);

  void addCalories(double calories) {
    emit(state + calories);
  }

  void clearCalories() {
    emit(0.0);  // Reseta as calorias para 0
  }
}