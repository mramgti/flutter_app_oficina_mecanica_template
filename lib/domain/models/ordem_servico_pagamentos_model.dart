// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServicoPagamentos extends Entity {
  int? codOrdemServico;
  int? codTipoPagamento;
  int? numParcelas;
  double? valorPago;

  OrdemServicoPagamentos({
    super.id,
    this.codOrdemServico,
    this.codTipoPagamento,
    this.numParcelas,
    this.valorPago,
  });

  OrdemServicoPagamentos copyWith({
    int? id,
    int? codOrdemServico,
    int? codTipoPagamento,
    int? numParcelas,
    double? valorPago,
  }) {
    return OrdemServicoPagamentos(
      id: id ?? this.id,
      codOrdemServico: codOrdemServico ?? this.codOrdemServico,
      codTipoPagamento: codTipoPagamento ?? this.codTipoPagamento,
      numParcelas: numParcelas ?? this.numParcelas,
      valorPago: valorPago ?? this.valorPago,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CodOrdemServico': codOrdemServico,
      'CodTipoPagamento': codTipoPagamento,
      'NumParcelas': numParcelas,
      'ValorPago': valorPago,
    };
  }

  factory OrdemServicoPagamentos.fromMap(Map<String, dynamic> map) {
    return OrdemServicoPagamentos(
      id: map['id'] != null ? map['id'] as int : null,
      codOrdemServico: map['CodOrdemServico'] != null ? map['CodOrdemServico'] as int : null,
      codTipoPagamento: map['CodTipoPagamento'] != null ? map['CodTipoPagamento'] as int : null,
      numParcelas: map['NumParcelas'] != null ? map['NumParcelas'] as int : null,
      valorPago: map['ValorPago'] != null ? map['ValorPago'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoPagamentos.fromJson(String source) => OrdemServicoPagamentos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServicoPagamentos(id: $id, codOrdemServico: $codOrdemServico, codTipoPagamento: $codTipoPagamento, numParcelas: $numParcelas, valorPago: $valorPago)';
  }

  @override
  bool operator ==(covariant OrdemServicoPagamentos other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.codOrdemServico == codOrdemServico &&
      other.codTipoPagamento == codTipoPagamento &&
      other.numParcelas == numParcelas &&
      other.valorPago == valorPago;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      codOrdemServico.hashCode ^
      codTipoPagamento.hashCode ^
      numParcelas.hashCode ^
      valorPago.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServicoPagamentos.fromMap(map);
  }
}
