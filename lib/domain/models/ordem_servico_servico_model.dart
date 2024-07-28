// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServicoServico extends Entity {
  int? codOrdemServico;
  int? codServico;
  String? cpf;

  OrdemServicoServico({
    super.id,
    this.codOrdemServico,
    this.codServico,
    this.cpf,
  });

  OrdemServicoServico copyWith({
    int? id,
    int? codOrdemServico,
    int? codServico,
    String? cpf,
  }) {
    return OrdemServicoServico(
      id: id ?? this.id,
      codOrdemServico: codOrdemServico ?? this.codOrdemServico,
      codServico: codServico ?? this.codServico,
      cpf: cpf ?? this.cpf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CodOrdemServico': codOrdemServico,
      'CodServico': codServico,
      'CPF': cpf,
    };
  }

  factory OrdemServicoServico.fromMap(Map<String, dynamic> map) {
    return OrdemServicoServico(
      id: map['id'] != null ? map['id'] as int : null,
      codOrdemServico: map['CodOrdemServico'] != null ? map['CodOrdemServico'] as int : null,
      codServico: map['CodServico'] != null ? map['CodServico'] as int : null,
      cpf: map['CPF'] != null ? map['CPF'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoServico.fromJson(String source) =>
      OrdemServicoServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServicoServico(id: $id, codOrdemServico: $codOrdemServico, codServico: $codServico, cpf: $cpf)';
  }

  @override
  bool operator ==(covariant OrdemServicoServico other) {
    if (identical(this, other)) return true;

    return 
        other.id == id &&
        other.codOrdemServico == codOrdemServico &&
        other.codServico == codServico &&
        other.cpf == cpf;
  }

  @override
  int get hashCode {
    return 
        id.hashCode ^
        codOrdemServico.hashCode ^
        codServico.hashCode ^
        cpf.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServicoServico.fromMap(map);
  }
}
