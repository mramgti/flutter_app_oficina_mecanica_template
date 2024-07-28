// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Endereco extends Entity {
  String? rua;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  String? pontoReferencia;
  String? telefone;
  String? cpf;
  String? cnpj;

  Endereco({
    super.id,
    this.rua,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.estado,
    this.cep,
    this.pontoReferencia,
    this.telefone,
    this.cpf,
    this.cnpj,
  });

  Endereco copyWith({
    int? id,
    String? rua,
    String? numero,
    String? complemento,
    String? bairro,
    String? cidade,
    String? estado,
    String? cep,
    String? pontoReferencia,
    String? telefone,
    String? cpf,
    String? cnpj,
  }) {
    return Endereco(
      id: id ?? this.id,
      rua: rua ?? this.rua,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      pontoReferencia: pontoReferencia ?? this.pontoReferencia,
      telefone: telefone ?? this.telefone,
      cpf: cpf ?? this.cpf,
      cnpj: cnpj ?? this.cnpj,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Rua': rua,
      'Numero': numero,
      'Complemento': complemento,
      'Bairro': bairro,
      'Cidade': cidade,
      'Estado': estado,
      'CEP': cep,
      'PontoReferencia': pontoReferencia,
      'Telefone': telefone,
      'CPF': cpf,
      'CNPJ': cnpj,
    };
  }

  factory Endereco.fromMap(Map<String, dynamic> map) {
    return Endereco(
      id: map['id'] != null ? map['id'] as int : null,
      rua: map['Rua'] != null ? map['Rua'] as String : null,
      numero: map['Numero'] != null ? map['Numero'] as String : null,
      complemento: map['Complemento'] != null ? map['Complemento'] as String : null,
      bairro: map['Bairro'] != null ? map['Bairro'] as String : null,
      cidade: map['Cidade'] != null ? map['Cidade'] as String : null,
      estado: map['Estado'] != null ? map['Estado'] as String : null,
      cep: map['CEP'] != null ? map['CEP'] as String : null,
      pontoReferencia: map['PontoReferencia'] != null ? map['PontoReferencia'] as String : null,
      telefone: map['Telefone'] != null ? map['Telefone'] as String : null,
      cpf: map['CPF'] != null ? map['CPF'] as String : null,
      cnpj: map['CNPJ'] != null ? map['CNPJ'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Endereco.fromJson(String source) =>
      Endereco.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Endereco(id: $id, rua: $rua, numero: $numero, complemento: $complemento, bairro: $bairro, cidade: $cidade, estado: $estado, cep: $cep, pontoReferencia: $pontoReferencia, telefone: $telefone, cpf: $cpf, cnpj: $cnpj)';
  }

  @override
  bool operator ==(covariant Endereco other) {
    if (identical(this, other)) return true;

    return 
        other.id == id &&
        other.rua == rua &&
        other.numero == numero &&
        other.complemento == complemento &&
        other.bairro == bairro &&
        other.cidade == cidade &&
        other.estado == estado &&
        other.cep == cep &&
        other.pontoReferencia == pontoReferencia &&
        other.telefone == telefone &&
        other.cpf == cpf &&
        other.cnpj == cnpj;
  }

  @override
  int get hashCode {
    return 
        id.hashCode ^
        rua.hashCode ^
        numero.hashCode ^
        complemento.hashCode ^
        bairro.hashCode ^
        cidade.hashCode ^
        estado.hashCode ^
        cep.hashCode ^
        pontoReferencia.hashCode ^
        telefone.hashCode ^
        cpf.hashCode ^
        cnpj.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Endereco.fromMap(map);
  }
}
