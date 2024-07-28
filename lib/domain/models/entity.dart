// ignore_for_file: public_member_api_docs, sort_constructors_first
///Representa a classe base
///para todas as entidades
abstract class Entity {
  
  int? id;

  String tableName = "";

  String primarykey = "id";

  Entity({
    this.id,    
  });

  Map<String, dynamic> toMap();
  Entity fromMap(Map<String, dynamic> map);

}
