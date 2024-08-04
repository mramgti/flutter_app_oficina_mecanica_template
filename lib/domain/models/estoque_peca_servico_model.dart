// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class EstoquePecaServico extends Entity {
  int? idPecaServico;
  String? nome;
  double? precoCompra;
  double? precoVenda;
  int? quantidade;
  int? idTipoPecaServico;

  EstoquePecaServico({
    this.idPecaServico,
    this.nome,
    this.precoCompra,
    this.precoVenda,
    this.quantidade,
    this.idTipoPecaServico,
  });

  EstoquePecaServico copyWith({
    int? idPecaServico,
    String? nome,
    double? precoCompra,
    double? precoVenda,
    int? quantidade,
    int? idTipoPecaServico,
  }) {
    return EstoquePecaServico(
      idPecaServico: idPecaServico ?? this.idPecaServico,
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
      'idPecaServico': idPecaServico,
      'nome': nome,
      'precoCompra': precoCompra,
      'precoVenda': precoVenda,
      'quantidade': quantidade,
      'idTipoPecaServico': idTipoPecaServico,
    };
  }

  factory EstoquePecaServico.fromMap(Map<String, dynamic> map) {
    return EstoquePecaServico(
      idPecaServico: map['idPecaServico'] != null ? map['idPecaServico'] as int : null,
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
    return 'EstoquePecaServico(idPecaServico: $idPecaServico, nome: $nome, precoCompra: $precoCompra, precoVenda: $precoVenda, quantidade: $quantidade, idTipoPecaServico: $idTipoPecaServico)';
  }

  @override
  bool operator ==(covariant EstoquePecaServico other) {
    if (identical(this, other)) return true;

    return
      other.idPecaServico == idPecaServico && 
      other.nome == nome &&
      other.precoCompra == precoCompra &&
      other.precoVenda == precoVenda &&
      other.quantidade == quantidade &&
      other.idTipoPecaServico == idTipoPecaServico;
  }

  @override
  int get hashCode {
    return 
      idPecaServico.hashCode ^
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
  
  get getValueId => idPecaServico;
  
  @override
  
  String get primarykey => "idPecaServico";
  
  @override
  
  String get tableName => "estoquePecaServico";
}
