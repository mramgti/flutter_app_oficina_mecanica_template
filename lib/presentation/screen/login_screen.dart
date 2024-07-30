import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/home_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/intro_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/general_text_field.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "login";
  LoginScreen({super.key});

  // Text input controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                const SizedBox(
                  height: 50,
                ),
                // logo
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.person_2,
                    size: 100,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                // Text

                const Text(
                  'Bem vindo à Oficina Mecânica!',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(
                  'Preencha os campos para ter acesso ao aplicativo.',
                  style: TextStyle(
                      color: Color.fromARGB(148, 17, 15, 15),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),

                const SizedBox(
                  height: 35,
                ),

                // Username textfield
                GeneralTextField(
                  controller: usernameController,
                  hintText: 'Usuário',
                  obscuretext: false,
                ),

                const SizedBox(
                  height: 35,
                ),

                // Password textfield
                GeneralTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscuretext: true,
                ),

                const SizedBox(
                  height: 100,
                ),

                // Sign in Button
                LoginButton(
                    onTap: () => Navigator.pushNamed(context, HomeScreen.routeName)),
              ],
            ),
          ),
        ));
  }
}
