// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class FornecedorEstoquePecas extends Entity {
  int? idFornecedorEstoquePecas;
  int? idFornecedor;
  int? idPecaServico;

  FornecedorEstoquePecas({
    this.idFornecedorEstoquePecas,
    this.idFornecedor,
    this.idPecaServico,
  });

  FornecedorEstoquePecas copyWith({
    int? idFornecedorEstoquePecas,
    int? idFornecedor,
    int? idPecaServico,
  }) {
    return FornecedorEstoquePecas(
      idFornecedorEstoquePecas: idFornecedorEstoquePecas ?? this.idFornecedorEstoquePecas,
      idFornecedor: idFornecedor ?? this.idFornecedor,
      idPecaServico: idPecaServico ?? this.idPecaServico,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFornecedorEstoquePecas': idFornecedorEstoquePecas,
      'idFornecedor': idFornecedor,
      'idPecaServico': idPecaServico,
    };
  }

  factory FornecedorEstoquePecas.fromMap(Map<String, dynamic> map) {
    return FornecedorEstoquePecas(
      idFornecedorEstoquePecas: map['idFornecedorEstoquePecas'] != null ? map['idFornecedorEstoquePecas'] as int : null,
      idFornecedor: map['idFornecedor'] != null ? map['idFornecedor'] as int : null,
      idPecaServico: map['idPecaServico'] != null ? map['idPecaServico'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FornecedorEstoquePecas.fromJson(String source) => FornecedorEstoquePecas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FornecedorEstoquePecas(idFornecedorEstoquePecas: $idFornecedorEstoquePecas, idFornecedor: $idFornecedor, idPecaServico: $idPecaServico)';

  @override
  bool operator ==(covariant FornecedorEstoquePecas other) {
    if (identical(this, other)) return true;
  
    return 
      other.idFornecedorEstoquePecas == idFornecedorEstoquePecas &&
      other.idFornecedor == idFornecedor &&
      other.idPecaServico == idPecaServico;
  }

  @override
  int get hashCode => idFornecedorEstoquePecas.hashCode ^ idFornecedor.hashCode ^ idPecaServico.hashCode;

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
