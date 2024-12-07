import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_diet/AlertDialog/cubit_calorias.dart';
import 'package:simple_diet/AlertDialog/food_kcal_alert_dialog.dart';

import 'cubit_text.dart';

class CalcularRefeicaoScreen extends StatefulWidget {
  @override
  _CalcularRefeicaoScreenState createState() => _CalcularRefeicaoScreenState();
}

class _CalcularRefeicaoScreenState extends State<CalcularRefeicaoScreen> {
  final comidaController = TextEditingController();
  final quantidadeController = TextEditingController();

    Future<void> _showAlertDialog(String nome, double quantidade) async {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
                nome: nome,
                quantidade: quantidade);
          }
      );
    }

  void limpar() {
    comidaController.clear();
    quantidadeController.clear();
    context.read<CalorieCubit>().clearCalories();
  }


  void calcular() {
    String comida = comidaController.text;
    String quantidade = quantidadeController.text;

    if (comida.isNotEmpty && quantidade.isNotEmpty) {
      double? quantidadeNum = double.tryParse(quantidade);
      _showAlertDialog(comida, quantidadeNum!);

    } else {
      print('Por favor, preencha todos os campos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcular Refeição'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Calcular Refeição',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: comidaController,
              decoration: InputDecoration(
                labelText: 'Comida',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: quantidadeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantidade (g)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: calcular,
                  child: Text('Somar'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: limpar,
                  child: Text('Limpar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            BlocBuilder<CalorieCubit, double>(
                builder: (context, totalKcal) {
                  double kcalSomadas = 0.0;
                  kcalSomadas = kcalSomadas + totalKcal;
                  return Text(
                    "Calorias Somadas: $kcalSomadas kcal",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  );
                }
            )
          ],
        ),
      ),
    );
  }
}