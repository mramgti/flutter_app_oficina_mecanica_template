// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class EstoquePecaServico extends Entity {
  int? idEstoquePecaServico;
  String? nome;
  double? precoCompra;
  double? precoVenda;
  int? quantidade;
  int? idTipoPecaServico;

  EstoquePecaServico({
    this.idEstoquePecaServico,
    this.nome,
    this.precoCompra,
    this.precoVenda,
    this.quantidade,
    this.idTipoPecaServico,
  });

  EstoquePecaServico copyWith({
    int? idEstoquePecaServico,
    String? nome,
    double? precoCompra,
    double? precoVenda,
    int? quantidade,
    int? idTipoPecaServico,
  }) {
    return EstoquePecaServico(
      idEstoquePecaServico: idEstoquePecaServico ?? this.idEstoquePecaServico,
      nome: nome ?? this.nome,
      precoCompra: precoCompra ?? this.precoCompra,
      precoVenda: precoVenda ?? this.precoVenda,
      quantidade: quantidade ?? this.quantidade,
      idTipoPecaServico: idTipoPecaServico ?? this.idTipoPecaServico,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEstoquePecaServico': idEstoquePecaServico,
      'nome': nome,
      'precoCompra': precoCompra,
      'precoVenda': precoVenda,
      'quantidade': quantidade,
      'idTipoPecaServico': idTipoPecaServico,
    };
  }

  factory EstoquePecaServico.fromMap(Map<String, dynamic> map) {
    return EstoquePecaServico(
      idEstoquePecaServico: map['idEstoquePecaServico'] != null ? map['idEstoquePecaServico'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      precoCompra: map['precoCompra'] != null ? map['precoCompra'] as double : null,
      precoVenda: map['precoVenda'] != null ? map['precoVenda'] as double : null,
      quantidade: map['quantidade'] != null ? map['quantidade'] as int : null,
      idTipoPecaServico: map['idTipoPecaServico'] != null ? map['idTipoPecaServico'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstoquePecaServico.fromJson(String source) => EstoquePecaServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EstoquePecaServico(idEstoquePecaServico: $idEstoquePecaServico, nome: $nome, precoCompra: $precoCompra, precoVenda: $precoVenda, quantidade: $quantidade, idTipoPecaServico: $idTipoPecaServico)';
  }

  @override
  bool operator ==(covariant EstoquePecaServico other) {
    if (identical(this, other)) return true;

    return
      other.idEstoquePecaServico == idEstoquePecaServico && 
      other.nome == nome &&
      other.precoCompra == precoCompra &&
      other.precoVenda == precoVenda &&
      other.quantidade == quantidade &&
      other.idTipoPecaServico == idTipoPecaServico;
  }

  @override
  int get hashCode {
    return 
      idEstoquePecaServico.hashCode ^
      nome.hashCode ^
      precoCompra.hashCode ^
      precoVenda.hashCode ^
      quantidade.hashCode ^
      idTipoPecaServico.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return EstoquePecaServico.fromMap(map);
  }
  
  @override
  
  get getValueId => idEstoquePecaServico;
  
  @override
  
  String get primarykey => "idEstoquePecaServico";
  
  @override
  
  String get tableName => "estoquePecaServico";
}
