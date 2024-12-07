import 'dart:io';
import 'package:flutter/material.dart';
import 'package:simple_diet/model/food.dart';

class FavFoodsScreen extends StatefulWidget {
  @override
  _FavFoodsScreenState createState() => _FavFoodsScreenState();
}

class _FavFoodsScreenState extends State<FavFoodsScreen> {
  List<Alimentos> favFoods = [];


  Future<void> loadFavFoods() async {
    try {
      final file = File('/data/user/0/com.example.simple_diet/app_flutter/favorito.txt');


      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<String> lines = contents.split('\n');


        setState(() {
          favFoods = lines.map((line) {
            final parts = line.split('|');
            if (parts.length == 3) {
              return Alimentos(
                nome: parts[0],
                calorias: double.tryParse(parts[1]) ?? 0.0,
                carboidratos: double.tryParse(parts[2]) ?? 0.0,
                proteina: 0.0,
                gordura: 0.0,
              );
            } else {
              return Alimentos(
                nome: parts[0],
                calorias: 0.0,
                carboidratos: 0.0,
                proteina: 0.0,
                gordura: 0.0,
              );
            }
          }).toList();
        });
      }
    } catch (e) {
      print('Erro ao carregar alimentos favoritos: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadFavFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alimentos Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: favFoods.length,
          itemBuilder: (context, index) {
            Alimentos alimento = favFoods[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  alimento.nome,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}