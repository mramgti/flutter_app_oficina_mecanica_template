// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoPecaServico extends Entity {
  int? idTipoPecaServico;
  String? nome;

  TipoPecaServico({
    this.idTipoPecaServico,
    this.nome,
  });

  TipoPecaServico copyWith({
    int? idTipoPecaServico,
    String? nome,
  }) {
    return TipoPecaServico(
      idTipoPecaServico: idTipoPecaServico ?? this.idTipoPecaServico,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTipoPecaServico': idTipoPecaServico,
      'nome': nome,
    };
  }

  factory TipoPecaServico.fromMap(Map<String, dynamic> map) {
    return TipoPecaServico(
      idTipoPecaServico: map['idTipoPecaServico'] != null ? map['idTipoPecaServico'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoPecaServico.fromJson(String source) => TipoPecaServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TipoPecaServico(idTipoPecaServico: $idTipoPecaServico, nome: $nome)';

  @override
  bool operator ==(covariant TipoPecaServico other) {
    if (identical(this, other)) return true;
  
    return 
      other.idTipoPecaServico == idTipoPecaServico &&
      other.nome == nome;
  }

  @override
  int get hashCode => idTipoPecaServico.hashCode ^ nome.hashCode;

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoPecaServico.fromMap(map);
  }
  
  @override
  
  get getValueId => idTipoPecaServico;
  
  @override
  
  String get primarykey => "idTipoPecaServico";
  
  @override
  
  String get tableName => "tipoPecaServico";
}
