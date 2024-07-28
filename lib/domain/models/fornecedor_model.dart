// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Fornecedor extends Entity {
  String? cnpj;
  String? nome;
  String? dataCadastro;

  Fornecedor({
    super.id,
    this.cnpj,
    this.nome,
    this.dataCadastro,
  });

  Fornecedor copyWith({
    int? id,
    String? cnpj,
    String? nome,
    String? dataCadastro,
  }) {
    return Fornecedor(
      id: id ?? this.id,
      cnpj: cnpj ?? this.cnpj,
      nome: nome ?? this.nome,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CNPJ': cnpj,
      'Nome': nome,
      'DataCadastro': dataCadastro,
    };
  }

  factory Fornecedor.fromMap(Map<String, dynamic> map) {
    return Fornecedor(
      id: map['id'] != null ? map['id'] as int : null,
      cnpj: map['CNPJ'] != null ? map['CNPJ'] as String : null,
      nome: map['Nome'] != null ? map['CNPJ'] as String : null,
      dataCadastro: map['DataCadastro'] != null ? map['DataCadastro'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fornecedor.fromJson(String source) => Fornecedor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Fornecedor(id: $id, cnpj: $cnpj, nome: $nome, dataCadastro: $dataCadastro)';
  }

  @override
  bool operator ==(covariant Fornecedor other) {
    if (identical(this, other)) return true;

    return
      other.id == id && 
      other.cnpj == cnpj &&
      other.nome == nome &&
      other.dataCadastro == dataCadastro;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      cnpj.hashCode ^
      nome.hashCode ^
      dataCadastro.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Fornecedor.fromMap(map);
  }
}
