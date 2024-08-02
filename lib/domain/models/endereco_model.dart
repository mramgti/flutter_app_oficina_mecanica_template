// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Endereco extends Entity {
  int? idEndereco;
  String? rua;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  String? pontoReferencia;
  String? telefone;
  int? idCliente;
  int? idFornecedor;

  Endereco({
    this.idEndereco,
    this.rua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.pontoReferencia,
    this.telefone,
    this.idCliente,
    this.idFornecedor,
  });

  Endereco copyWith({
    int? idEndereco,
    String? rua,
    String? numero,
    String? complemento,
    String? bairro,
    String? cidade,
    String? estado,
    String? cep,
    String? pontoReferencia,
    String? telefone,
    int? idCliente,
    int? idFornecedor,
  }) {
    return Endereco(
      idEndereco: idEndereco ?? this.idEndereco,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      pontoReferencia: pontoReferencia ?? this.pontoReferencia,
      telefone: telefone ?? this.telefone,
      idCliente: idCliente ?? this.idCliente,
      idFornecedor: idFornecedor ?? this.idFornecedor,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEndereco': idEndereco,
      'rua': rua,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
      'pontoReferencia': pontoReferencia,
      'telefone': telefone,
      'idCliente': idCliente,
      'idFornecedor': idFornecedor,
    };
  }

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      idEndereco: map['idEndereco'] != null ? map['idEndereco'] as int : null,
      rua: map['rua'] != null ? map['rua'] as String : null,
      numero: map['numero'] != null ? map['numero'] as String : null,
      complemento: map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      cidade: map['cidade'] != null ? map['cidade'] as String : null,
      estado: map['estado'] != null ? map['estado'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      pontoReferencia: map['pontoReferencia'] != null ? map['pontoReferencia'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      idCliente: map['idCliente'] != null ? map['idCliente'] as int : null,
      idFornecedor: map['idFornecedor'] != null ? map['idFornecedor'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Endereco.fromJson(String source) =>
      Endereco.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Endereco(idEndereco: $idEndereco, rua: $rua, numero: $numero, complemento: $complemento, bairro: $bairro, cidade: $cidade, estado: $estado, cep: $cep, pontoReferencia: $pontoReferencia, telefone: $telefone, idCliente: $idCliente, idFornecedor: $idFornecedor)';
  }

  @override
  bool operator ==(covariant Endereco other) {
    if (identical(this, other)) return true;
  
    return 
      other.idEndereco == idEndereco &&
      other.rua == rua &&
      other.numero == numero &&
      other.complemento == complemento &&
      other.bairro == bairro &&
      other.cidade == cidade &&
      other.estado == estado &&
      other.cep == cep &&
      other.pontoReferencia == pontoReferencia &&
      other.telefone == telefone &&
      other.idCliente == idCliente &&
      other.idFornecedor == idFornecedor;
  }

  @override
  int get hashCode {
    return idEndereco.hashCode ^
      rua.hashCode ^
      numero.hashCode ^
      complemento.hashCode ^
      bairro.hashCode ^
      cidade.hashCode ^
      estado.hashCode ^
      cep.hashCode ^
      pontoReferencia.hashCode ^
      telefone.hashCode ^
      idCliente.hashCode ^
      idFornecedor.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Endereco.fromMap(map);
  }
  
  @override
  
  get getValueId => idEndereco;
  
  @override
  
  String get primarykey => "idEndereco";
  
  @override
  
  String get tableName => "endereco";
}
