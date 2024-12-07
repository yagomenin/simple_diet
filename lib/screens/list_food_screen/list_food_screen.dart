import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_diet/retrofit/food_api.dart';
import '../../model/food.dart';

class ListFoodsScreen extends StatefulWidget {
  @override
  _ListFoodsScreenState createState() => _ListFoodsScreenState();
}

class _ListFoodsScreenState extends State<ListFoodsScreen> {
  late Future<List<Alimentos>> alimentosList;

  Future<List<Alimentos>> fetchFoods() async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      return await client.getAllFoods();
    } catch (e) {
      throw Exception("Erro ao carregar os alimentos: $e");
    }
  }


  Future<void> saveFavoriteFood(Alimentos alimento) async {

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/favorito.txt');
    print('Salvando arquivo em: ${file.path}');


    String foodDetails = '${alimento.nome}, ${alimento.calorias} kcal, '
        '${alimento.carboidratos}g carboidratos, '
        '${alimento.proteina}g proteínas, '
        '${alimento.gordura}g gorduras\n';


    if (!await file.exists()) {
      await file.create();
    }


    await file.writeAsString(foodDetails, mode: FileMode.append);


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${alimento.nome} foi adicionado aos favoritos!')),
    );
  }

  @override
  void initState() {
    super.initState();
    alimentosList = fetchFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Alimentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Alimentos>>(
          future: alimentosList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Erro: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("Nenhum alimento encontrado"));
            }

            List<Alimentos> alimentos = snapshot.data!;

            return ListView.builder(
              itemCount: alimentos.length,
              itemBuilder: (context, index) {
                Alimentos alimento = alimentos[index];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      alimento.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Calorias: ${alimento.calorias} kcal"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          onPressed: () {
                            saveFavoriteFood(alimento);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(alimento.nome),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Carboidratos: ${alimento.carboidratos} g"),
                                      Text("Proteínas: ${alimento.proteina} g"),
                                      Text("Gorduras: ${alimento.gordura} g"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Fechar"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
