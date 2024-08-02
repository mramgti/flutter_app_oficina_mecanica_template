// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoFuncionario extends Entity {
  
  int? idTipoFuncionario;
  String? nome;

  TipoFuncionario({
    this.idTipoFuncionario,
    this.nome,
  });

  TipoFuncionario copyWith({
    int? idTipoFuncionario,
    String? nome,
  }) {
    return TipoFuncionario(
      idTipoFuncionario: idTipoFuncionario ?? this.idTipoFuncionario,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTipoFuncionario': idTipoFuncionario,
      'nome': nome,
    };
  }

  factory TipoFuncionario.fromMap(Map<String, dynamic> map) {
    return TipoFuncionario(
      idTipoFuncionario: map['idTipoFuncionario'] != null ? map['idTipoFuncionario'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoFuncionario.fromJson(String source) => TipoFuncionario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipoFuncionario(idTipoFuncionario: $idTipoFuncionario, nome: $nome)';
  }

  @override
  bool operator ==(covariant TipoFuncionario other) {
    if (identical(this, other)) return true;

    return 
      other.idTipoFuncionario == idTipoFuncionario &&
      other.nome == nome;
  }

  @override
  int get hashCode {
    return 
      idTipoFuncionario.hashCode ^
      nome.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoFuncionario.fromMap(map);
  }
  
  @override
  
  get getValueId => idTipoFuncionario;
  
  @override
  
  String get primarykey => "idTipoFuncionario";
  
  @override
  
  String get tableName => "tipoFuncionario";
}
