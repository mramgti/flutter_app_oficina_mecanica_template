// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter_app_oficina_mecanica_template/domain/models/entity.dart';

class TipoStatus extends Entity {
  String? status;

  TipoStatus({
    super.id,
    this.status,
  });

  TipoStatus copyWith({
    int? id,
    String? status,
  }) {
    return TipoStatus(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Status': status,
    };
  }

  factory TipoStatus.fromMap(Map<String, dynamic> map) {
    return TipoStatus(
      id: map['id'] != null ? map['id'] as int : null,
      status: map['Status'] != null ? map['Status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TipoStatus.fromJson(String source) => TipoStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TipoStatus(id: $id, status: $status)';
  }

  @override
  bool operator ==(covariant TipoStatus other) {
    if (identical(this, other)) return true;

    return
      other.id == id && 
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      status.hashCode;
  }

  @override
  Entity fromMap(Map<String, dynamic> map) {
    return TipoStatus.fromMap(map);
  }
}
