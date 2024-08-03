import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/fornecedor/fornecedor_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/funcionarios/funcionarios_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_funcionario/tipo_funcionario_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_pagamento/tipo_pagamento_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_servico/tipo_servico_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_status/tipo_status_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/menu_box.dart';

class AdminScreen extends StatelessWidget {
  static const String routeName = "AdminScreen";

  AdminScreen({super.key});
  final List options = [
    [
      'CARGOS',
      const Icon(
        Icons.badge,
        size: 40,
        color: Colors.white,
      ),
      TipoFuncionarioSearchScreen.routeName
    ],
    [
      'PAGAMENTO',
      const Icon(Icons.payment, size: 40, color: Colors.white),
      TipoPagamentoSearchScreen.routeName
    ],
    [
      'SERVIÇO',
      const Icon(Icons.build, size: 40, color: Colors.white),
      TipoPecaServicoSearchScreen.routeName
    ],
    [
      'FUNCIONÁRIOS',
      const Icon(Icons.supervisor_account, size: 40, color: Colors.white),
      FuncionariosSearchScreen.routeName
    ],
        [
      'FORNECEDOR',
      const Icon(Icons.local_shipping, size: 40, color: Colors.white),
      FornecedorSearchScreen.routeName
    ],
    [
      'STATUS',
      const Icon(Icons.assignment_turned_in, size: 40, color: Colors.white),
      TipoStatusSearchScreen.routeName
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Administrador'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text('Bem Vindo,'),
              //           Text(
              //             'João Pedro',
              //             style: TextStyle(fontSize: 35),
              //           )
              //         ],
              //       ),
              //       Icon(
              //         Icons.car_repair,
              //         size: 100,
              //         color: Theme.of(context).colorScheme.inversePrimary,
              //       )
              //     ],
              //   ),
              // ),

              const SizedBox(
                height: 25,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 0.6,
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              // Items Grid
              Expanded(
                child: GridView.builder(
                  itemCount: options.length,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, // Largura máxima de cada item
                    childAspectRatio: 1 / 1.1, // Proporção de aspecto do item
                    crossAxisSpacing:
                        16, // Espaçamento entre os itens na direção horizontal
                    mainAxisSpacing:
                        16, // Espaçamento entre os itens na direção vertical
                  ),
                  itemBuilder: (context, index) {
                    return MenuBox(
                      name: options[index][0],
                      icon: options[index][1],
                      routeName: options[index][2],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
