// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoFuncionario extends Entity {
  String? nome;

  TipoFuncionario({
    super.id,
    this.nome,
  });

  TipoFuncionario copyWith({
    int? id,
    String? nome,
  }) {
    return TipoFuncionario(
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

  factory TipoFuncionario.fromMap(Map<String, dynamic> map) {
    return TipoFuncionario(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['Nome'] != null ? map['Nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoFuncionario.fromJson(String source) => TipoFuncionario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipoFuncionario(id: $id, nome: $nome)';
  }

  @override
  bool operator ==(covariant TipoFuncionario other) {
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
    return TipoFuncionario.fromMap(map);
  }
}
