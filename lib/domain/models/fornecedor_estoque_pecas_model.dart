// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class FornecedorEstoquePecas extends Entity {
  int? idFornecedorEstoquePecas;
  int? idFornecedor;
  int? idEstoquePecaServico;

  FornecedorEstoquePecas({
    this.idFornecedorEstoquePecas,
    this.idFornecedor,
    this.idEstoquePecaServico,
  });

  FornecedorEstoquePecas copyWith({
    int? idFornecedorEstoquePecas,
    int? idFornecedor,
    int? idEstoquePecaServico,
  }) {
    return FornecedorEstoquePecas(
      idFornecedorEstoquePecas: idFornecedorEstoquePecas ?? this.idFornecedorEstoquePecas,
      idFornecedor: idFornecedor ?? this.idFornecedor,
      idEstoquePecaServico: idEstoquePecaServico ?? this.idEstoquePecaServico,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFornecedorEstoquePecas': idFornecedorEstoquePecas,
      'idFornecedor': idFornecedor,
      'idEstoquePecaServico': idEstoquePecaServico,
    };
  }

  factory FornecedorEstoquePecas.fromMap(Map<String, dynamic> map) {
    return FornecedorEstoquePecas(
      idFornecedorEstoquePecas: map['idFornecedorEstoquePecas'] != null ? map['idFornecedorEstoquePecas'] as int : null,
      idFornecedor: map['idFornecedor'] != null ? map['idFornecedor'] as int : null,
      idEstoquePecaServico: map['idEstoquePecaServico'] != null ? map['idEstoquePecaServico'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FornecedorEstoquePecas.fromJson(String source) => FornecedorEstoquePecas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FornecedorEstoquePecas(idFornecedorEstoquePecas: $idFornecedorEstoquePecas, idFornecedor: $idFornecedor, idEstoquePecaServico: $idEstoquePecaServico)';

  @override
  bool operator ==(covariant FornecedorEstoquePecas other) {
    if (identical(this, other)) return true;
  
    return 
      other.idFornecedorEstoquePecas == idFornecedorEstoquePecas &&
      other.idFornecedor == idFornecedor &&
      other.idEstoquePecaServico == idEstoquePecaServico;
  }

  @override
  int get hashCode => idFornecedorEstoquePecas.hashCode ^ idFornecedor.hashCode ^ idEstoquePecaServico.hashCode;

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return FornecedorEstoquePecas.fromMap(map);
  }
  
  @override
  
  get getValueId => idFornecedorEstoquePecas;
  
  @override
  
  String get primarykey => "idFornecedorEstoquePecas";
  
  @override
  
  String get tableName => "fornecedorEstoquePecas";
}
