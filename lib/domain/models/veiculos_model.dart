// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Veiculos extends Entity {
  String? placa;
  String? marca;
  String? modelo;
  String? cor;
  int? ano;

  Veiculos({
    super.id,
    this.placa,
    this.marca,
    this.modelo,
    this.cor,
    this.ano,
  });

  Veiculos copyWith({
    int? id,
    String? placa,
    String? marca,
    String? modelo,
    String? cor,
    int? ano,
  }) {
    return Veiculos(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      cor: cor ?? this.cor,
      ano: ano ?? this.ano,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Placa': placa,
      'Marca': marca,
      'Modelo': modelo,
      'Cor': cor,
      'Ano': ano,
    };
  }

  factory Veiculos.fromMap(Map<String, dynamic> map) {
    return Veiculos(
      id: map['id'] != null ? map['id'] as int : null,
      placa: map['Placa'] != null ? map['Placa'] as String : null,
      marca: map['Marca'] != null ? map['Marca'] as String : null,
      modelo: map['Modelo'] != null ? map['Modelo'] as String : null,
      cor: map['Cor'] != null ? map['Cor'] as String : null,
      ano: map['Ano'] != null ? map['Ano'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Veiculos.fromJson(String source) =>
      Veiculos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Veiculos(id: $id, placa: $placa, marca: $marca, modelo: $modelo, cor: $cor, ano: $ano)';
  }

  @override
  bool operator ==(covariant Veiculos other) {
    if (identical(this, other)) return true;

    return 
        other.id == id &&
        other.placa == placa &&
        other.marca == marca &&
        other.modelo == modelo &&
        other.cor == cor &&
        other.ano == ano;
  }

  @override
  int get hashCode {
    return 
        id.hashCode ^
        placa.hashCode ^
        marca.hashCode ^
        modelo.hashCode ^
        cor.hashCode ^
        ano.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Veiculos.fromMap(map);
  }
}
