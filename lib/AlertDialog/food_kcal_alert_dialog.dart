import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_diet/model/food.dart';
import '../retrofit/food_api.dart';
import 'cubit_calorias.dart';

class CustomAlertDialog extends StatefulWidget {
  final String nome;
  final double quantidade;

  CustomAlertDialog({
    required this.nome,
    required this.quantidade
   });

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  late List<Alimentos> alimentos;
  late Alimentos alimento;
  bool isLoading = true;
  String errorMessage = '';

  Future<void> fetchFoodData() async {
    print(widget.nome);
    print("AQUI EU CHEGUEI");
    try {
      final dio = Dio();
      final client = RestClient(dio);
      print(widget.nome);
      alimentos = await client.getAllFoods();
      alimento = await client.getFood(widget.nome.trim().toLowerCase().toString());
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        for (var alimento in alimentos) {
          print("Nome: ${alimento.nome}");
          print("Calorias: ${alimento.calorias}");
          print("Carboidratos: ${alimento.carboidratos}");
          print("Proteína: ${alimento.proteina}");
          print("Gordura: ${alimento.gordura}");
          print("----------------------");
        }
        isLoading = false;
        errorMessage = 'Erro ao carregar os dados: $e';
        print("$e");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodData();
    print("OI KRL");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Informações de ${widget.nome}'),
      content: isLoading
          ? CircularProgressIndicator()
          : errorMessage.isNotEmpty
          ? Text(errorMessage)
          : alimento != null
          ? Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Nome do alimento: ${alimento.nome}'),
          Text('Calorias: ${alimento.calorias}'),
          Text('Carboidratos: ${alimento.carboidratos}'),
          Text('Proteínas: ${alimento.proteina}'),
          Text('Gorduras: ${alimento.gordura}'),
        ],
      ) : Text('Nenhum dado encontrado'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            double kcalTotal = alimento.calorias * (widget.quantidade / 100);
            context.read<CalorieCubit>().addCalories(kcalTotal);
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancelar"),
        ),
      ],
    );
  }
}