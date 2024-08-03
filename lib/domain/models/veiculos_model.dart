// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Veiculos extends Entity {
  int? idVeiculo;
  String? placa;
  String? marca;
  String? modelo;
  String? cor;
  int? ano;
  int? idCliente;

  Veiculos({
    this.idVeiculo,
    this.placa,
    this.marca,
    this.modelo,
    this.cor,
    this.ano,
    this.idCliente,
  });

  Veiculos copyWith({
    int? idVeiculo,
    String? placa,
    String? marca,
    String? modelo,
    String? cor,
    int? ano,
    int? idCliente,
  }) {
    return Veiculos(
      idVeiculo: idVeiculo ?? this.idVeiculo,
      placa: placa ?? this.placa,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      cor: cor ?? this.cor,
      ano: ano ?? this.ano,
      idCliente: idCliente ?? this.idCliente,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idVeiculo': idVeiculo,
      'placa': placa,
      'marca': marca,
      'modelo': modelo,
      'cor': cor,
      'ano': ano,
      'idCliente': idCliente,
    };
  }

  factory Veiculos.fromMap(Map<String, dynamic> map) {
    return Veiculos(
      idVeiculo: map['idVeiculo'] != null ? map['idVeiculo'] as int : null,
      placa: map['placa'] != null ? map['placa'] as String : null,
      marca: map['marca'] != null ? map['marca'] as String : null,
      modelo: map['modelo'] != null ? map['modelo'] as String : null,
      cor: map['cor'] != null ? map['cor'] as String : null,
      ano: map['ano'] != null ? map['ano'] as int : null,
      idCliente: map['idCliente'] != null ? map['idCliente'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Veiculos.fromJson(String source) =>
      Veiculos.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Veiculos(idVeiculo: $idVeiculo, placa: $placa, marca: $marca, modelo: $modelo, cor: $cor, ano: $ano, idCliente: $idCliente)';
  // }

  @override
  String toString() {
    return modelo ??
        ''; // Retorna o modelo ou uma string vazia se modelo for nulo
  }

  @override
  bool operator ==(covariant Veiculos other) {
    if (identical(this, other)) return true;

    return other.idVeiculo == idVeiculo &&
        other.placa == placa &&
        other.marca == marca &&
        other.modelo == modelo &&
        other.cor == cor &&
        other.ano == ano &&
        other.idCliente == idCliente;
  }

  @override
  int get hashCode {
    return idVeiculo.hashCode ^
        placa.hashCode ^
        marca.hashCode ^
        modelo.hashCode ^
        cor.hashCode ^
        ano.hashCode ^
        idCliente.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Veiculos.fromMap(map);
  }

  @override
  get getValueId => idVeiculo;

  @override
  String get primarykey => "idVeiculo";

  @override
  String get tableName => "veiculos";
}
