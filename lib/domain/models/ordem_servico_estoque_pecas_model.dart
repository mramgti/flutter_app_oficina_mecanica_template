// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServicoEstoquePecas extends Entity {
  int? codOrdemServico;
  int? codPeca;
  String? cpf;
  double? valorPeca;
  int? quantPeca;

  OrdemServicoEstoquePecas({
    super.id,
    this.codOrdemServico,
    this.codPeca,
    this.cpf,
    this.valorPeca,
    this.quantPeca,
  });

  OrdemServicoEstoquePecas copyWith({
    int? id,
    int? codOrdemServico,
    int? codPeca,
    String? cpf,
    double? valorPeca,
    int? quantPeca,
  }) {
    return OrdemServicoEstoquePecas(
      id: id ?? this.id,
      codOrdemServico: codOrdemServico ?? this.codOrdemServico,
      codPeca: codPeca ?? this.codPeca,
      cpf: cpf ?? this.cpf,
      valorPeca: valorPeca ?? this.valorPeca,
      quantPeca: quantPeca ?? this.quantPeca,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CodOrdemServico': codOrdemServico,
      'CodPeca': codPeca,
      'CPF': cpf,
      'ValorPeca': valorPeca,
      'QuantPeca': quantPeca,
    };
  }

  factory OrdemServicoEstoquePecas.fromMap(Map<String, dynamic> map) {
    return OrdemServicoEstoquePecas(
      id: map['id'] != null ? map['id'] as int : null,
      codOrdemServico: map['CodOrdemServico'] != null ? map['CodOrdemServico'] as int : null,
      codPeca: map['CodPeca'] != null ? map['CodPeca'] as int : null,
      cpf: map['CPF'] != null ? map['CPF'] as String : null,
      valorPeca: map['ValorPeca'] != null ? (map['ValorPeca'] as num).toDouble() : 0.0,
      quantPeca: map['QuantPeca'] != null ? map['QuantPeca'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoEstoquePecas.fromJson(String source) =>
      OrdemServicoEstoquePecas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServicoEstoquePecas(id: $id, codOrdemServico: $codOrdemServico, codPeca: $codPeca, cpf: $cpf, valorPeca: $valorPeca, quantPeca: $quantPeca)';
  }

  @override
  bool operator ==(covariant OrdemServicoEstoquePecas other) {
    if (identical(this, other)) return true;

    return 
        other.id == id &&
        other.codOrdemServico == codOrdemServico &&
        other.codPeca == codPeca &&
        other.cpf == cpf &&
        other.valorPeca == valorPeca &&
        other.quantPeca == quantPeca;
  }

  @override
  int get hashCode {
    return 
        id.hashCode ^
        codOrdemServico.hashCode ^
        codPeca.hashCode ^
        cpf.hashCode ^
        valorPeca.hashCode ^
        quantPeca.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServicoEstoquePecas.fromMap(map);
  }
}
