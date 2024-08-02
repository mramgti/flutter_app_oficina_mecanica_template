// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServico extends Entity {
  int? idOrdemServico;
  int? idTipoStatus;
  int? idFuncionario;
  int? idCliente;
  int? idVeiculo;
  int? idTipoPagamento;
  String? dataHoraEntregaVeiculo;
  String? dataHoraInicioServico;
  String? dataHoraFimServico;
  int? quilometragem;
  double? valorPago;


  OrdemServico({
    this.idOrdemServico,
    this.idTipoStatus,
    this.idFuncionario,
    this.idCliente,
    this.idVeiculo,
    this.idTipoPagamento,
    this.dataHoraEntregaVeiculo,
    this.dataHoraInicioServico,
    this.dataHoraFimServico,
    this.quilometragem,
    this.valorPago,
  });

  OrdemServico copyWith({
    int? idOrdemServico,
    int? idTipoStatus,
    int? idFuncionario,
    int? idCliente,
    int? idVeiculo,
    int? idTipoPagamento,
    String? dataHoraEntregaVeiculo,
    String? dataHoraInicioServico,
    String? dataHoraFimServico,
    int? quilometragem,
    double? valorPago,
  }) {
    return OrdemServico(
      idOrdemServico: idOrdemServico ?? this.idOrdemServico,
      idTipoStatus: idTipoStatus ?? this.idTipoStatus,
      idFuncionario: idFuncionario ?? this.idFuncionario,
      idCliente: idCliente ?? this.idCliente,
      idVeiculo: idVeiculo ?? this.idVeiculo,
      idTipoPagamento: idTipoPagamento ?? this.idTipoPagamento,
      dataHoraEntregaVeiculo: dataHoraEntregaVeiculo ?? this.dataHoraEntregaVeiculo,
      dataHoraInicioServico: dataHoraInicioServico ?? this.dataHoraInicioServico,
      dataHoraFimServico: dataHoraFimServico ?? this.dataHoraFimServico,
      quilometragem: quilometragem ?? this.quilometragem,
      valorPago: valorPago ?? this.valorPago,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idOrdemServico': idOrdemServico,
      'idTipoStatus': idTipoStatus,
      'idFuncionario': idFuncionario,
      'idCliente': idCliente,
      'idVeiculo': idVeiculo,
      'idTipoPagamento': idTipoPagamento,
      'dataHoraEntregaVeiculo': dataHoraEntregaVeiculo,
      'dataHoraInicioServico': dataHoraInicioServico,
      'dataHoraFimServico': dataHoraFimServico,
      'quilometragem': quilometragem,
      'valorPago': valorPago,
    };
  }

  factory OrdemServico.fromMap(Map<String, dynamic> map) {
    return OrdemServico(
      idOrdemServico: map['idOrdemServico'] != null ? map['idOrdemServico'] as int : null,
      idTipoStatus: map['idTipoStatus'] != null ? map['idTipoStatus'] as int : null,
      idFuncionario: map['idFuncionario'] != null ? map['idFuncionario'] as int : null,
      idCliente: map['idCliente'] != null ? map['idCliente'] as int : null,
      idVeiculo: map['idVeiculo'] != null ? map['idVeiculo'] as int : null,
      idTipoPagamento: map['idTipoPagamento'] != null ? map['idTipoPagamento'] as int : null,
      dataHoraEntregaVeiculo: map['dataHoraEntregaVeiculo'] != null ? map['dataHoraEntregaVeiculo'] as String : null,
      dataHoraInicioServico: map['dataHoraInicioServico'] != null ? map['dataHoraInicioServico'] as String : null,
      dataHoraFimServico: map['dataHoraFimServico'] != null ? map['dataHoraFimServico'] as String : null,
      quilometragem: map['quilometragem'] != null ? map['quilometragem'] as int : null,
      valorPago: map['valorPago'] != null ? map['valorPago'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServico.fromJson(String source) => OrdemServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServico(idOrdemServico: $idOrdemServico, idTipoStatus: $idTipoStatus, idFuncionario: $idFuncionario, idCliente: $idCliente, idVeiculo: $idVeiculo, idTipoPagamento: $idTipoPagamento, dataHoraEntregaVeiculo: $dataHoraEntregaVeiculo, dataHoraInicioServico: $dataHoraInicioServico, dataHoraFimServico: $dataHoraFimServico, quilometragem: $quilometragem, valorPago: $valorPago)';
  }

  @override
  bool operator ==(covariant OrdemServico other) {
    if (identical(this, other)) return true;
  
    return 
      other.idOrdemServico == idOrdemServico &&
      other.idTipoStatus == idTipoStatus &&
      other.idFuncionario == idFuncionario &&
      other.idCliente == idCliente &&
      other.idVeiculo == idVeiculo &&
      other.idTipoPagamento == idTipoPagamento &&
      other.dataHoraEntregaVeiculo == dataHoraEntregaVeiculo &&
      other.dataHoraInicioServico == dataHoraInicioServico &&
      other.dataHoraFimServico == dataHoraFimServico &&
      other.quilometragem == quilometragem &&
      other.valorPago == valorPago;
  }

  @override
  int get hashCode {
    return idOrdemServico.hashCode ^
      idTipoStatus.hashCode ^
      idFuncionario.hashCode ^
      idCliente.hashCode ^
      idVeiculo.hashCode ^
      idTipoPagamento.hashCode ^
      dataHoraEntregaVeiculo.hashCode ^
      dataHoraInicioServico.hashCode ^
      dataHoraFimServico.hashCode ^
      quilometragem.hashCode ^
      valorPago.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServico.fromMap(map);
  }
  
  @override
  
  get getValueId => idOrdemServico;
  
  @override
  
  String get primarykey => "idOrdemServico";
  
  @override
  
  String get tableName => "ordemServico";
}
