import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../AlertDialog/cubit_calorias.dart';

class CalorieDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalorieCubit, double>(
      builder: (context, totalKcal) {
        return Text("Calorias Somadas: $totalKcal kcal");
      },
    );
  }
}