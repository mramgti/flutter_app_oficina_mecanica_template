// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Funcionarios extends Entity {
  int? idFuncionario;
  String? senha;
  String? cpf;
  String? nome;
  String? dataNascimento;
  String? dataContratacao;
  double? salario;
  String? dataDemissao;

  int? idTipoFuncionario;

  Funcionarios({
    this.idFuncionario,
    this.senha,
    this.cpf,
    this.nome,
    this.dataNascimento,
    this.dataContratacao,
    this.salario,
    this.dataDemissao,
    this.idTipoFuncionario,
  });

  Funcionarios copyWith({
    int? idFuncionario,
    String? senha,
    String? cpf,
    String? nome,
    String? dataNascimento,
    String? dataContratacao,
    double? salario,
    String? dataDemissao,
    int? idTipoFuncionario,
  }) {
    return Funcionarios(
      idFuncionario: idFuncionario ?? this.idFuncionario,
      senha: senha ?? this.senha,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      dataContratacao: dataContratacao ?? this.dataContratacao,
      salario: salario ?? this.salario,
      dataDemissao: dataDemissao ?? this.dataDemissao,
      idTipoFuncionario: idTipoFuncionario ?? this.idTipoFuncionario,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFuncionario': idFuncionario,
      'senha': senha,
      'cpf': cpf,
      'nome': nome,
      'dataNascimento': dataNascimento,
      'dataContratacao': dataContratacao,
      'salario': salario,
      'dataDemissao': dataDemissao,
      'idTipoFuncionario': idTipoFuncionario,
    };
  }

  factory Funcionarios.fromMap(Map<String, dynamic> map) {
    return Funcionarios(
      idFuncionario:
          map['idFuncionario'] != null ? map['idFuncionario'] as int : null,
      senha: map['senha'] != null ? map['senha'] as String : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      dataNascimento: map['dataNascimento'] != null
          ? map['dataNascimento'] as String
          : null,
      dataContratacao: map['dataContratacao'] != null
          ? map['dataContratacao'] as String
          : null,
      salario: map['salario'] != null ? map['salario'] as double : null,
      dataDemissao:
          map['dataDemissao'] != null ? map['dataDemissao'] as String : null,
      idTipoFuncionario: map['idTipoFuncionario'] != null
          ? map['idTipoFuncionario'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Funcionarios.fromJson(String source) =>
      Funcionarios.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Funcionarios(idFuncionario: $idFuncionario, senha: $senha, cpf: $cpf, nome: $nome, dataNascimento: $dataNascimento, dataContratacao: $dataContratacao, salario: $salario, dataDemissao: $dataDemissao, idTipoFuncionario: $idTipoFuncionario)';
  // }

  @override
  String toString() {
    return nome ??
        ''; // Retorna o modelo ou uma string vazia se modelo for nulo
  }

  @override
  bool operator ==(covariant Funcionarios other) {
    if (identical(this, other)) return true;

    return other.idFuncionario == idFuncionario &&
        other.senha == senha &&
        other.cpf == cpf &&
        other.nome == nome &&
        other.dataNascimento == dataNascimento &&
        other.dataContratacao == dataContratacao &&
        other.salario == salario &&
        other.dataDemissao == dataDemissao &&
        other.idTipoFuncionario == idTipoFuncionario;
  }

  @override
  int get hashCode {
    return idFuncionario.hashCode ^
        senha.hashCode ^
        cpf.hashCode ^
        nome.hashCode ^
        dataNascimento.hashCode ^
        dataContratacao.hashCode ^
        salario.hashCode ^
        dataDemissao.hashCode ^
        idTipoFuncionario.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Funcionarios.fromMap(map);
  }

  @override
  get getValueId => idFuncionario;

  @override
  String get primarykey => "idFuncionario";

  @override
  String get tableName => "funcionarios";
}
