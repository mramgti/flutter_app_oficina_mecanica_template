// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class OrdemServico extends Entity {
  int? codTipoStatus;
  String? dataHoraEntregaVeiculo;
  String? dataHoraInicioServico;
  String? dataHoraFimServico;
  int? quilometragem;

  OrdemServico({
    super.id,
    this.codTipoStatus,
    this.dataHoraEntregaVeiculo,
    this.dataHoraInicioServico,
    this.dataHoraFimServico,
    this.quilometragem,
  });

  OrdemServico copyWith({
    int? id,
    int? codTipoStatus,
    String? dataHoraEntregaVeiculo,
    String? dataHoraInicioServico,
    String? dataHoraFimServico,
    int? quilometragem,
  }) {
    return OrdemServico(
      id: id ?? this.id,
      codTipoStatus: codTipoStatus ?? this.codTipoStatus,
      dataHoraEntregaVeiculo: dataHoraEntregaVeiculo ?? this.dataHoraEntregaVeiculo,
      dataHoraInicioServico: dataHoraInicioServico ?? this.dataHoraInicioServico,
      dataHoraFimServico: dataHoraFimServico ?? this.dataHoraFimServico,
      quilometragem: quilometragem ?? this.quilometragem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'CodTipoStatus': codTipoStatus,
      'DataHoraEntregaVeiculo': dataHoraEntregaVeiculo,
      'DataHoraInicioServico': dataHoraInicioServico,
      'DataHoraFimServico': dataHoraFimServico,
      'Quilometragem': quilometragem,
    };
  }

  factory OrdemServico.fromMap(Map<String, dynamic> map) {
    return OrdemServico(
      id: map['id'] != null ? map['id'] as int : null,
      codTipoStatus: map['CodTipoStatus'] != null ? map['CodTipoStatus'] as int : null,
      dataHoraEntregaVeiculo: map['DataHoraEntregaVeiculo'] != null ? map['DataHoraEntregaVeiculo'] as String : null,
      dataHoraInicioServico: map['DataHoraInicioServico'] != null ? map['DataHoraInicioServico'] as String : null,
      dataHoraFimServico: map['DataHoraFimServico'] != null ? map['DataHoraFimServico'] as String : null,
      quilometragem: map['Quilometragem'] != null ? map['Quilometragem'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrdemServico.fromJson(String source) => OrdemServico.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrdemServico(id: $id, codTipoStatus: $codTipoStatus, dataHoraEntregaVeiculo: $dataHoraEntregaVeiculo, dataHoraInicioServico: $dataHoraInicioServico, dataHoraFimServico: $dataHoraFimServico, quilometragem: $quilometragem)';
  }

  @override
  bool operator ==(covariant OrdemServico other) {
    if (identical(this, other)) return true;

    return 
      other.id == id &&
      other.codTipoStatus == codTipoStatus &&
      other.dataHoraEntregaVeiculo == dataHoraEntregaVeiculo &&
      other.dataHoraInicioServico == dataHoraInicioServico &&
      other.dataHoraFimServico == dataHoraFimServico &&
      other.quilometragem == quilometragem;
  }

  @override
  int get hashCode {
    return 
      id.hashCode ^
      codTipoStatus.hashCode ^
      dataHoraEntregaVeiculo.hashCode ^
      dataHoraInicioServico.hashCode ^
      dataHoraFimServico.hashCode ^
      quilometragem.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return OrdemServico.fromMap(map);
  }
}
