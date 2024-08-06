import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/funcionarios_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/models/tipo_funcionario_model.dart';
import 'package:flutter_app_oficina_mecanica_template/domain/repositories/repository_sqlite.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/home_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/intro_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/general_text_field.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/login_button.dart';
import 'package:flutter_app_oficina_mecanica_template/data/database_provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  LoginScreen({super.key});

  // Text input controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final repository = RepositorySQLite(DatabaseProvider());

  Future<void> validateLogin(BuildContext context) async {
    String cpf = usernameController.text;
    String senha = passwordController.text;

    // Busca no banco de dados
    Funcionarios? user = await repository.findUserByCpfAndSenha(cpf, senha); 
    if (user != null) {
      TipoFuncionario? tipoFuncionario = await repository.findTipoFuncionarioById(user.idTipoFuncionario);

      if (tipoFuncionario != null) {
        Navigator.pushNamed(context, HomeScreen.routeName, arguments: tipoFuncionario);
      } else {
        _showErrorDialog(context, "Tipo de usuário não encontrado.");
      }
    } else {
      _showErrorDialog(context, "Usuário ou senha incorretos.");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Erro"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          onPressed: () => Navigator.pushNamed(context, IntroScreen.routeName),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.person_2, size: 100, color: Colors.white),
              ),
              const SizedBox(height: 50),
              const Text(
                'Bem vindo à Oficina Mecânica!',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Preencha os campos para ter acesso ao aplicativo.',
                style: TextStyle(color: Color.fromARGB(148, 17, 15, 15), fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(height: 35),
              GeneralTextField(
                controller: usernameController,
                hintText: 'Usuário',
                obscuretext: false,
              ),
              const SizedBox(height: 35),
              GeneralTextField(
                controller: passwordController,
                hintText: 'Senha',
                obscuretext: true,
              ),
              const SizedBox(height: 100),
              LoginButton(onTap: () => validateLogin(context)),
            ],
          ),
        ),
      ),
    );
  }
}
