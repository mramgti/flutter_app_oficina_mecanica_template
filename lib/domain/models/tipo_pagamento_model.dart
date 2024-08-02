// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoPagamento extends Entity {
  int? idTipoPagamento;
  String? nome;

  TipoPagamento({
    this.idTipoPagamento,
    this.nome,
  });

  TipoPagamento copyWith({
    int? idTipoPagamento,
    String? nome,
  }) {
    return TipoPagamento(
      idTipoPagamento: idTipoPagamento ?? this.idTipoPagamento,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTipoPagamento': idTipoPagamento,
      'nome': nome,
    };
  }

  factory TipoPagamento.fromMap(Map<String, dynamic> map) {
    return TipoPagamento(
      idTipoPagamento: map['idTipoPagamento'] != null ? map['idTipoPagamento'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoPagamento.fromJson(String source) => TipoPagamento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TipoPagamento(idTipoPagamento: $idTipoPagamento, nome: $nome)';

  @override
  bool operator ==(covariant TipoPagamento other) {
    if (identical(this, other)) return true;
  
    return 
      other.idTipoPagamento == idTipoPagamento &&
      other.nome == nome;
  }

  @override
  int get hashCode => idTipoPagamento.hashCode ^ nome.hashCode;

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoPagamento.fromMap(map);
  }
  
  @override
  
  get getValueId => idTipoPagamento;
  
  @override
  
  String get primarykey => "idTipoPagamento";
  
  @override
  
  String get tableName => "tipoPagamento";
}
