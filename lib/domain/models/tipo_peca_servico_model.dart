// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoPecaServico extends Entity {
  String? nome;

  TipoPecaServico({
    super.id,
    this.nome,
  });

  TipoPecaServico copyWith({
    int? id,
    String? nome,
  }) {
    return TipoPecaServico(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Nome': nome,
    };
  }

  factory TipoPecaServico.fromMap(Map<String, dynamic> map) {
    return TipoPecaServico(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['Nome'] != null ? map['Nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoPecaServico.fromJson(String source) => TipoPecaServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipoPecaServico(id: $id, nome: $nome)';
  }

  @override
  bool operator ==(covariant TipoPecaServico other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.nome == nome;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      nome.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoPecaServico.fromMap(map);
  }
}
