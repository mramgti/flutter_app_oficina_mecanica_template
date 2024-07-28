// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class FornecedorEstoquePecas extends Entity {
  String? cnpj;
  int? codPeca;

  FornecedorEstoquePecas({
    super.id,
    this.cnpj,
    this.codPeca,
  });

  FornecedorEstoquePecas copyWith({
    int? id,
    String? cnpj,
    int? codPeca,
  }) {
    return FornecedorEstoquePecas(
      id: id ?? this.id,
      cnpj: cnpj ?? this.cnpj,
      codPeca: codPeca ?? this.codPeca,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CNPJ': cnpj,
      'CodPeca': codPeca,
    };
  }

  factory FornecedorEstoquePecas.fromMap(Map<String, dynamic> map) {
    return FornecedorEstoquePecas(
      id: map['id'] != null ? map['id'] as int : null,
      cnpj: map['CNPJ'] != null ? map['CNPJ'] as String : null,
      codPeca: map['CodPeca'] != null ? map['CodPeca'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FornecedorEstoquePecas.fromJson(String source) => FornecedorEstoquePecas.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FornecedorEstoquePecas(id: $id, cnpj: $cnpj, codPeca: $codPeca)';
  }

  @override
  bool operator ==(covariant FornecedorEstoquePecas other) {
    if (identical(this, other)) return true;

    return
      other.id == id &&
      other.cnpj == cnpj &&
      other.codPeca == codPeca;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      cnpj.hashCode ^
      codPeca.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return FornecedorEstoquePecas.fromMap(map);
  }
}
