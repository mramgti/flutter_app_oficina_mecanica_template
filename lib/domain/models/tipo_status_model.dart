// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoStatus extends Entity {
  int? idTipoStatus;
  String? nome;

  TipoStatus({
    this.idTipoStatus,
    this.nome,
  });

  TipoStatus copyWith({
    int? idTipoStatus,
    String? nome,
  }) {
    return TipoStatus(
      idTipoStatus: idTipoStatus ?? this.idTipoStatus,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTipoStatus': idTipoStatus,
      'nome': nome,
    };
  }

  factory TipoStatus.fromMap(Map<String, dynamic> map) {
    return TipoStatus(
      idTipoStatus:
          map['idTipoStatus'] != null ? map['idTipoStatus'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoStatus.fromJson(String source) =>
      TipoStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() => 'TipoStatus(idTipoStatus: $idTipoStatus, nome: $nome)';

  @override
  String toString() {
    return nome ?? ''; // Retorna o nome ou uma string vazia se nome for nulo
  }

  @override
  bool operator ==(covariant TipoStatus other) {
    if (identical(this, other)) return true;

    return other.idTipoStatus == idTipoStatus && other.nome == nome;
  }

  @override
  int get hashCode => idTipoStatus.hashCode ^ nome.hashCode;

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoStatus.fromMap(map);
  }

  @override
  get getValueId => idTipoStatus;

  @override
  String get primarykey => "idTipoStatus";

  @override
  String get tableName => "tipoStatus";
}
