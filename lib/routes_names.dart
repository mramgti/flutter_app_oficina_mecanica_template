import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/admin_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/fornecedor/fornecedor_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/fornecedor/fornecedor_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/estoque_peca_servico/estoque_peca_servico_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/estoque_peca_servico/estoque_peca_servico_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/funcionarios/funcionarios.form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/funcionarios/funcionarios_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/ordem_servico/ordem_servico_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/ordem_servico/ordem_servico_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_funcionario/tipo_funcionario_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_funcionario/tipo_funcionario_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_pagamento/tipo_pagamento_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_pagamento/tipo_pagamento_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_servico/tipo_servico_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_servico/tipo_servico_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_status/tipo_status_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/tipo_status/tipo_status_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/veiculos/veiculos_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/endereco/endereco_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/home_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_search_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/clientes/clientes_form_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/intro_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/login_screen.dart';

class RoutesNames {
  static Map<String, WidgetBuilder> get routesNames => {
        IntroScreen.routeName: (context) => IntroScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ClientesSearchScreen.routeName: (context) => ClientesSearchScreen(),
        ClientesFormScreen.routeName: (context) => ClientesFormScreen(),
        VeiculosFormScreen.routeName: (context) => VeiculosFormScreen(),
        EnderecoSearchScreen.routeName: (context) => EnderecoSearchScreen(),
        EnderecoFormScreen.routeName: (context) => EnderecoFormScreen(),
        AdminScreen.routeName: (context) => AdminScreen(),
        TipoFuncionarioSearchScreen.routeName: (context) => TipoFuncionarioSearchScreen(),
        TipoFuncionarioFormScreen.routeName: (context) => TipoFuncionarioFormScreen(),
        TipoPagamentoSearchScreen.routeName: (context) => TipoPagamentoSearchScreen(),
        TipoPagamentoFormScreen.routeName: (context) => TipoPagamentoFormScreen(),
        TipoPecaServicoSearchScreen.routeName: (context) => TipoPecaServicoSearchScreen(),
        TipoPecaServicoFormScreen.routeName: (context) => TipoPecaServicoFormScreen(),
        TipoStatusSearchScreen.routeName: (context) => TipoStatusSearchScreen(),
        TipoStatusFormScreen.routeName: (context) => TipoStatusFormScreen(),
        FuncionariosSearchScreen.routeName: (context) => FuncionariosSearchScreen(),
        FuncionariosFormScreen.routeName: (context) => FuncionariosFormScreen(),
        FornecedorSearchScreen.routeName: (context) => FornecedorSearchScreen(),
        FornecedorFormScreen.routeName: (context) => FornecedorFormScreen(),
        OrdemServicoSearchScreen.routeName: (context) => OrdemServicoSearchScreen(),
        OrdemServicoFormScreen.routeName: (context) => OrdemServicoFormScreen(),
        EstoquePecaServicoSearchScreen.routeName: (context) => EstoquePecaServicoSearchScreen(),
        EstoquePecaServicoFormScreen.routeName: (context) => EstoquePecaServicoFormScreen(),
      };
}
