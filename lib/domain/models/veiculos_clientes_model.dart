// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class VeiculosClientes extends Entity {
  String? placa;
  String? cpf;

  VeiculosClientes({
    super.id,
    this.placa,
    this.cpf,
  });

  VeiculosClientes copyWith({
    int? id,
    String? placa,
    String? cpf,
  }) {
    return VeiculosClientes(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      cpf: cpf ?? this.cpf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Placa': placa,
      'CPF': cpf,
    };
  }

  factory VeiculosClientes.fromMap(Map<String, dynamic> map) {
    return VeiculosClientes(
      id: map['id'] != null ? map['id'] as int : null,
      placa: map['Placa'] != null ? map['Placa'] as String : null,
      cpf: map['CPF'] != null ? map['CPF'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VeiculosClientes.fromJson(String source) =>
      VeiculosClientes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VeiculosClientes(id: $id, placa: $placa, cpf: $cpf)';
  }

  @override
  bool operator ==(covariant VeiculosClientes other) {
    if (identical(this, other)) return true;

    return 
        other.id == id &&
        other.placa == placa &&
        other.cpf == cpf;
  }

  @override
  int get hashCode {
    return 
        id.hashCode ^
        placa.hashCode ^
        cpf.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return VeiculosClientes.fromMap(map);
  }
}
