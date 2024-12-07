import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Alimentos {
  final String nome;
  final double calorias;
  final double gordura;
  final double proteina;
  final double carboidratos;

  Alimentos({
    required this.nome,
    required this.calorias,
    required this.gordura,
    required this.proteina,
    required this.carboidratos
  });

  factory Alimentos.fromJson(Map<String, dynamic> json) => _$AlimentosFromJson(json);
  Map<String, dynamic> toJson() => _$AlimentosToJson(this);
}

