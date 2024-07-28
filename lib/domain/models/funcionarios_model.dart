// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class Funcionarios extends Entity {
  String? cpf;
  String? nome;
  String? dataContratacao;
  String? dataDemissao;
  String? dataNascimento;
  double? salario;
  String? dataAtribuicao;
  String? senha;
  int? codTipoFuncionario;

  Funcionarios({
    super.id,
    this.cpf,
    this.nome,
    this.dataContratacao,
    this.dataDemissao,
    this.dataNascimento,
    this.salario,
    this.dataAtribuicao,
    this.senha,
    this.codTipoFuncionario,
  });

  Funcionarios copyWith({
    int? id,
    String? cpf,
    String? nome,
    String? dataContratacao,
    String? dataDemissao,
    String? dataNascimento,
    double? salario,
    String? dataAtribuicao,
    String? senha,
    int? codTipoFuncionario,
  }) {
    return Funcionarios(
      id: id ?? this.id,
      cpf: cpf ?? this.cpf,
      nome: nome ?? this.nome,
      dataContratacao: dataContratacao ?? this.dataContratacao,
      dataDemissao: dataDemissao ?? this.dataDemissao,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      salario: salario ?? this.salario,
      dataAtribuicao: dataAtribuicao ?? this.dataAtribuicao,
      senha: senha ?? this.senha,
      codTipoFuncionario: codTipoFuncionario ?? this.codTipoFuncionario,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CPF': cpf,
      'Nome': nome,
      'DataContratacao': dataContratacao,
      'DataDemissao': dataDemissao,
      'DataNascimento': dataNascimento,
      'Salario': salario,
      'DataAtribuicao': dataAtribuicao,
      'Senha': senha,
      'CodTipoFuncionario': codTipoFuncionario,
    };
  }

  factory Funcionarios.fromMap(Map<String, dynamic> map) {
    return Funcionarios(
      id: map['id'] != null ? map['id'] as int : null,
      cpf: map['CPF'] != null ? map['CPF'] as String : null,
      nome: map['Nome'] != null ? map['Nome'] as String : null,
      dataContratacao: map['DataContratacao'] != null ? map['DataContratacao'] as String : null,
      dataDemissao: map['DataDemissao'] != null ? map['DataDemissao'] as String : null,
      dataNascimento: map['DataNascimento'] != null ? map['DataNascimento'] as String : null,
      salario: map['Salario'] != null ? map['Salario'] as double : null,
      dataAtribuicao: map['DataAtribuicao'] != null ? map['DataAtribuicao'] as String : null,
      senha: map['Senha'] != null ? map['Senha'] as String : null,
      codTipoFuncionario: map['CodTipoFuncionario'] != null ? map['CodTipoFuncionario'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Funcionarios.fromJson(String source) => Funcionarios.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Funcionarios(id: $id, cpf: $cpf, nome: $nome, dataContratacao: $dataContratacao, dataDemissao: $dataDemissao, dataNascimento: $dataNascimento, salario: $salario, dataAtribuicao: $dataAtribuicao, senha: $senha, codTipoFuncionario: $codTipoFuncionario)';
  }

  @override
  bool operator ==(covariant Funcionarios other) {
    if (identical(this, other)) return true;

    return
      other.id == id && 
      other.cpf == cpf &&
      other.nome == nome &&
      other.dataContratacao == dataContratacao &&
      other.dataDemissao == dataDemissao &&
      other.dataNascimento == dataNascimento &&
      other.salario == salario &&
      other.dataAtribuicao == dataAtribuicao &&
      other.senha == senha &&
      other.codTipoFuncionario == codTipoFuncionario;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      cpf.hashCode ^
      nome.hashCode ^
      dataContratacao.hashCode ^
      dataDemissao.hashCode ^
      dataNascimento.hashCode ^
      salario.hashCode ^
      dataAtribuicao.hashCode ^
      senha.hashCode ^
      codTipoFuncionario.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return Funcionarios.fromMap(map);
  }
}
