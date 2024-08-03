// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Clientes extends Entity {
  int? idCliente;
  String? cpf;
  String? nome;
  String? email;
  String? dataNascimento;
  
  Clientes({
    this.idCliente,
    this.cpf,
    this.nome,
    this.email,
    this.dataNascimento,
  });



  Clientes copyWith({
    int? idCliente,
    String? cpf,
    String? nome,
    String? email,
    String? dataNascimento,
  }) {
    return Clientes(
      idCliente: idCliente ?? this.idCliente,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      dataNascimento: dataNascimento ?? this.dataNascimento,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCliente': idCliente,
      'cpf': cpf,
      'nome': nome,
      'email': email,
      'dataNascimento': dataNascimento,
    };
  }


  factory Clientes.fromMap(Map<String, dynamic> map) {
    return Clientes(
      idCliente: map['idCliente'] != null ? map['idCliente'] as int : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      dataNascimento: map['dataNascimento'] != null ? map['dataNascimento'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Clientes.fromJson(String source) => Clientes.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Clientes(idCliente: $idCliente, cpf: $cpf, nome: $nome, email: $email, dataNascimento: $dataNascimento)';
  // }

@override
  String toString() {
    return nome ?? ''; // Retorna o nome ou uma string vazia se nome for nulo
  }

  @override
  bool operator ==(covariant Clientes other) {
    if (identical(this, other)) return true;
  
    return 
      other.idCliente == idCliente &&
      other.cpf == cpf &&
      other.nome == nome &&
      other.email == email &&
      other.dataNascimento == dataNascimento;
  }

  @override
  int get hashCode {
    return idCliente.hashCode ^
      cpf.hashCode ^
      nome.hashCode ^
      email.hashCode ^
      dataNascimento.hashCode;
  }
  
  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Clientes.fromMap(map);
  }
  
  @override

  get getValueId => idCliente;
  
  @override
  
  String get primarykey => "idCliente";
  
  @override
  
  String get tableName => "clientes";
}
