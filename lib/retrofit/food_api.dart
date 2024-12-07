import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/food.dart';

part 'food_api.g.dart';

const String baseUrl = 'http://192.168.2.21:3000';


@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/alimentos')
  Future<List<Alimentos>> getAllFoods();

  @GET('/alimentos/{nome}')
  Future<Alimentos> getFood(@Path('nome') String nome);
}