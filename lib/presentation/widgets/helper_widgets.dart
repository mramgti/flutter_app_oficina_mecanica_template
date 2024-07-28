import 'package:flutter/material.dart';

class HelperWidgets{

  /**
   * Utilizado para criar um campo do tipo TextFormField para utilizado
   * no Widget Form. O componente TextFormField e envolvido pelo Widget
   * Flexible.
   */
  static Widget createTextForm(String label, String? msgValidator, 
        TextEditingController controller){
    return Flexible(child: 
              TextFormField(
                controller: controller,
                decoration: InputDecoration(label: Text(label)),
                validator: (value) {
                  if (value != null && value.trim().isEmpty){
                     return msgValidator ?? "Campo obrigatório!";
                  } 
                },
              ), 
           );
  }

}