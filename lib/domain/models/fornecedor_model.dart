// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Fornecedor extends Entity {
  int? idFornecedor;
  String? cnpj;
  String? nome;

  Fornecedor({
    this.idFornecedor,
    this.cnpj,
    this.nome,
  });

  Fornecedor copyWith({
    int? idFornecedor,
    String? cnpj,
    String? nome,
  }) {
    return Fornecedor(
      idFornecedor: idFornecedor ?? this.idFornecedor,
      cnpj: cnpj ?? this.cnpj,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFornecedor': idFornecedor,
      'cnpj': cnpj,
      'nome': nome,
    };
  }

  factory Fornecedor.fromMap(Map<String, dynamic> map) {
    return Fornecedor(
      idFornecedor: map['idFornecedor'] != null ? map['idFornecedor'] as int : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Fornecedor.fromJson(String source) => Fornecedor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Fornecedor(idFornecedor: $idFornecedor, cnpj: $cnpj, nome: $nome)';

  @override
  bool operator ==(covariant Fornecedor other) {
    if (identical(this, other)) return true;
  
    return 
      other.idFornecedor == idFornecedor &&
      other.cnpj == cnpj &&
      other.nome == nome;
  }

  @override
  int get hashCode => idFornecedor.hashCode ^ cnpj.hashCode ^ nome.hashCode;

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Fornecedor.fromMap(map);
  }
  
  @override
  
  get getValueId => idFornecedor;
  
  @override
  
  String get primarykey => "idFornecedor";
  
  @override
  
  String get tableName => "fornecedor";
}
