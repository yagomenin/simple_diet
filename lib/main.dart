import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_diet/routes/routes.dart';
import 'package:simple_diet/screens/fav_foods_screen/fav_foods_screen.dart';
import 'package:simple_diet/screens/food_screen/calc_refeicao.dart';
import 'package:simple_diet/screens/list_food_screen/list_food_screen.dart';

import 'AlertDialog/cubit_calorias.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => CalorieCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Diet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: homeRoute,
      routes: {
        homeRoute: (context) => MyHomePage(),
        calcularRefRoute: (context) => CalcularRefeicaoScreen(),
        listaAlimentos: (context) => ListFoodsScreen(),
        alimentosFavRoute: (context) => FavFoodsScreen()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Diet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TweenAnimationBuilder<Color?>(
              tween: ColorTween(
                begin: Colors.amber,
                end: Colors.black,
              ),
              duration: Duration(seconds: 6),
              builder: (context, color, child) {
                return Text(
                  'Simple Diet',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, calcularRefRoute);
              },
              child: Text('Calcular Refeição'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, listaAlimentos);
                print('Lista de Alimentos');
              },
              child: Text('Lista de Alimentos'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, alimentosFavRoute);
              },
              child: Text('Alimentos Favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}