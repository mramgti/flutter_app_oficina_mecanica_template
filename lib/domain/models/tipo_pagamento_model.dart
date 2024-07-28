// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoPagamento extends Entity {
  String? descricao;

  TipoPagamento({
    super.id,
    this.descricao,
  });

  TipoPagamento copyWith({
    int? id,
    String? descricao,
  }) {
    return TipoPagamento(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Descricao': descricao,
    };
  }

  factory TipoPagamento.fromMap(Map<String, dynamic> map) {
    return TipoPagamento(
      id: map['id'] != null ? map['id'] as int : null,
      descricao: map['Descricao'] != null ? map['Descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoPagamento.fromJson(String source) => TipoPagamento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipoPagamento(id: $id, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant TipoPagamento other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.descricao == descricao;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      descricao.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoPagamento.fromMap(map);
  }
}
