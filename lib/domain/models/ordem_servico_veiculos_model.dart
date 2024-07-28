// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServicoVeiculos extends Entity {
  String? placa;
  int? codOrdemServico;

  OrdemServicoVeiculos({
    super.id,
    this.placa,
    this.codOrdemServico,
  });

  OrdemServicoVeiculos copyWith({
    int? id,
    String? placa,
    int? codOrdemServico,
  }) {
    return OrdemServicoVeiculos(
      id: id ?? this.id,
      placa: placa ?? this.placa,
      codOrdemServico: codOrdemServico ?? this.codOrdemServico,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Placa': placa,
      'CodOrdemServico': codOrdemServico,
    };
  }

  factory OrdemServicoVeiculos.fromMap(Map<String, dynamic> map) {
    return OrdemServicoVeiculos(
      id: map['id'] != null ? map['id'] as int : null,
      placa: map['Placa'] != null ? map['Placa'] as String : null,
      codOrdemServico: map['CodOrdemServico'] != null ? map['CodOrdemServico'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoVeiculos.fromJson(String source) =>
      OrdemServicoVeiculos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServicoVeiculos(id: $id, placa: $placa, codOrdemServico: $codOrdemServico)';
  }

  @override
  bool operator ==(covariant OrdemServicoVeiculos other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.placa == placa && 
      other.codOrdemServico == codOrdemServico;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      placa.hashCode ^
      codOrdemServico.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServicoVeiculos.fromMap(map);
  }
}
