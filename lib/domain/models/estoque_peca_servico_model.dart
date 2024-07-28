// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class EstoquePecaServico extends Entity {
  String? nome;
  double? precoCompra;
  double? precoVenda;
  int? quantidade;
  int? codTipoPecaServico;

  EstoquePecaServico({
    super.id,
    this.nome,
    this.precoCompra,
    this.precoVenda,
    this.quantidade,
    this.codTipoPecaServico,
  });

  EstoquePecaServico copyWith({
    int? id,
    String? nome,
    double? precoCompra,
    double? precoVenda,
    int? quantidade,
    int? codTipoPecaServico,
  }) {
    return EstoquePecaServico(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      precoCompra: precoCompra ?? this.precoCompra,
      precoVenda: precoVenda ?? this.precoVenda,
      quantidade: quantidade ?? this.quantidade,
      codTipoPecaServico: codTipoPecaServico ?? this.codTipoPecaServico,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Nome': nome,
      'PrecoCompra': precoCompra,
      'PrecoVenda': precoVenda,
      'Quantidade': quantidade,
      'CodTipoPecaServico': codTipoPecaServico,
    };
  }

  factory EstoquePecaServico.fromMap(Map<String, dynamic> map) {
    return EstoquePecaServico(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['Nome'] != null ? map['Nome'] as String : null,
      precoCompra: map['PrecoCompra'] != null ? map['PrecoCompra'] as double : null,
      precoVenda: map['PrecoVenda'] != null ? map['PrecoVenda'] as double : null,
      quantidade: map['Quantidade'] != null ? map['Quantidade'] as int : null,
      codTipoPecaServico: map['CodTipoPecaServico'] != null ? map['CodTipoPecaServico'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EstoquePecaServico.fromJson(String source) => EstoquePecaServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EstoquePecaServico(id: $id, nome: $nome, precoCompra: $precoCompra, precoVenda: $precoVenda, quantidade: $quantidade, codTipoPecaServico: $codTipoPecaServico)';
  }

  @override
  bool operator ==(covariant EstoquePecaServico other) {
    if (identical(this, other)) return true;

    return
      other.id == id && 
      other.nome == nome &&
      other.precoCompra == precoCompra &&
      other.precoVenda == precoVenda &&
      other.quantidade == quantidade &&
      other.codTipoPecaServico == codTipoPecaServico;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      nome.hashCode ^
      precoCompra.hashCode ^
      precoVenda.hashCode ^
      quantidade.hashCode ^
      codTipoPecaServico.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return EstoquePecaServico.fromMap(map);
  }
}
