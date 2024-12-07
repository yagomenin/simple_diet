// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alimentos _$AlimentosFromJson(Map<String, dynamic> json) => Alimentos(
      nome: json['nome'] as String,
      calorias: (json['calorias'] as num).toDouble(),
      gordura: (json['gordura'] as num).toDouble(),
      proteina: (json['proteina'] as num).toDouble(),
      carboidratos: (json['carboidratos'] as num).toDouble(),
    );

Map<String, dynamic> _$AlimentosToJson(Alimentos instance) => <String, dynamic>{
      'nome': instance.nome,
      'calorias': instance.calorias,
      'gordura': instance.gordura,
      'proteina': instance.proteina,
      'carboidratos': instance.carboidratos,
    };
