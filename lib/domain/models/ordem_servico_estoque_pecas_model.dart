// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServicoEstoquePecas extends Entity {
  int? idOrdemServicoEstoquePecas;
  int? idOrdemServico;
  int? idEstoquePecaServico;
  double? preco;
  int? quantidade;

  OrdemServicoEstoquePecas({
    this.idOrdemServicoEstoquePecas,
    this.idOrdemServico,
    this.idEstoquePecaServico,
    this.preco,
    this.quantidade,
  });

  OrdemServicoEstoquePecas copyWith({
    int? idOrdemServicoEstoquePecas,
    int? idOrdemServico,
    int? idEstoquePecaServico,
    double? preco,
    int? quantidade,
  }) {
    return OrdemServicoEstoquePecas(
      idOrdemServicoEstoquePecas: idOrdemServicoEstoquePecas ?? this.idOrdemServicoEstoquePecas,
      idOrdemServico: idOrdemServico ?? this.idOrdemServico,
      idEstoquePecaServico: idEstoquePecaServico ?? this.idEstoquePecaServico,
      preco: preco ?? this.preco,
      quantidade: quantidade ?? this.quantidade,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idOrdemServicoEstoquePecas': idOrdemServicoEstoquePecas,
      'idOrdemServico': idOrdemServico,
      'idEstoquePecaServico': idEstoquePecaServico,
      'preco': preco,
      'quantidade': quantidade,
    };
  }

  factory OrdemServicoEstoquePecas.fromMap(Map<String, dynamic> map) {
    return OrdemServicoEstoquePecas(
      idOrdemServicoEstoquePecas: map['idOrdemServicoEstoquePecas'] != null ? map['idOrdemServicoEstoquePecas'] as int : null,
      idOrdemServico: map['idOrdemServico'] != null ? map['idOrdemServico'] as int : null,
      idEstoquePecaServico: map['idEstoquePecaServico'] != null ? map['idEstoquePecaServico'] as int : null,
      preco: map['preco'] != null ? map['preco'] as double : null,
      quantidade: map['quantidade'] != null ? map['quantidade'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServicoEstoquePecas.fromJson(String source) =>
      OrdemServicoEstoquePecas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServicoEstoquePecas(idOrdemServicoEstoquePecas: $idOrdemServicoEstoquePecas, idOrdemServico: $idOrdemServico, idEstoquePecaServico: $idEstoquePecaServico, preco: $preco, quantidade: $quantidade)';
  }

  @override
  bool operator ==(covariant OrdemServicoEstoquePecas other) {
    if (identical(this, other)) return true;
  
    return 
      other.idOrdemServicoEstoquePecas == idOrdemServicoEstoquePecas &&
      other.idOrdemServico == idOrdemServico &&
      other.idEstoquePecaServico == idEstoquePecaServico &&
      other.preco == preco &&
      other.quantidade == quantidade;
  }

  @override
  int get hashCode {
    return idOrdemServicoEstoquePecas.hashCode ^
      idOrdemServico.hashCode ^
      idEstoquePecaServico.hashCode ^
      preco.hashCode ^
      quantidade.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServicoEstoquePecas.fromMap(map);
  }
  
  @override
  
  get getValueId => idOrdemServicoEstoquePecas;
  
  @override
  
  String get primarykey => "idOrdemServicoEstoquePecas";
  
  @override
  
  String get tableName => "ordemServicoEstoquePecas";
}
