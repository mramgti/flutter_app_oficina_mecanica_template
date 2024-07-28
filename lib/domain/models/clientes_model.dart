// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Clientes extends Entity {
  String? cpf;
  String? nome;
  String? email;
  String? dataNascimento;
  String? dataCadastro;
  int? codOrdemServico;
  Clientes({
    super.id,
    this.cpf,
    this.nome,
    this.email,
    this.dataNascimento,
    this.dataCadastro,
    this.codOrdemServico,
  });



  Clientes copyWith({
    int? id,
    String? cpf,
    String? nome,
    String? email,
    String? dataNascimento,
    String? dataCadastro,
    int? codOrdemServico,
  }) {
    return Clientes(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      codOrdemServico: codOrdemServico ?? this.codOrdemServico,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id' : id,
      'CPF': cpf,
      'Nome': nome,
      'Email': email,
      'DataNascimento': dataNascimento,
      'DataCadastro': dataCadastro,
      'CodOrdemServico': codOrdemServico,
    };
  }

  factory Clientes.fromMap(Map<String, dynamic> map) {
    return Clientes(
      id: map['id'] != null ? map['id'] as int : null,
      cpf: map['CPF'] as String,
      nome: map['Nome'] as String,
      email: map['Email'] != null ? map['Email'] as String : null,
      dataNascimento: map['DataNascimento'] != null ? map['DataNascimento'] as String : null,
      dataCadastro: map['DataCadastro'] != null ? map['DataCadastro'] as String : null,
      codOrdemServico: map['CodOrdemServico'] != null ? map['CodOrdemServico'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Clientes.fromJson(String source) => Clientes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Clientes(id: $id, cpf: $cpf, nome: $nome, email: $email, dataNascimento: $dataNascimento, dataCadastro: $dataCadastro, codOrdemServico: $codOrdemServico)';
  }

  @override
  bool operator ==(covariant Clientes other) {
    if (identical(this, other)) return true;
  
    return
      other.id ==id && 
      other.cpf == cpf &&
      other.nome == nome &&
      other.email == email &&
      other.dataNascimento == dataNascimento &&
      other.dataCadastro == dataCadastro &&
      other.codOrdemServico == codOrdemServico;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      cpf.hashCode ^
      nome.hashCode ^
      email.hashCode ^
      dataNascimento.hashCode ^
      dataCadastro.hashCode ^
      codOrdemServico.hashCode;
  }
  
  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Clientes.fromMap(map);
  }
}
