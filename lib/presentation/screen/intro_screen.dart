import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/login_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/general_button.dart';


class IntroScreen extends StatelessWidget {
  static const String routeName = "/";
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            const Icon(
              Icons.build,
              size: 82,
              color: Colors.white,
            ),

            const SizedBox(
              height: 25,
            ),
            //title
            const Text('Oficina Mecânica',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),

            const SizedBox(
              height: 10,
            ),
            //subtitle
            const Text(
              'O melhor lugal para levar seu carro',
              style: TextStyle(
                  color: Color.fromARGB(195, 255, 255, 255)),
            ),
            // button to login

            const SizedBox(
              height: 15,
            ),
            GeneralButton(
                onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
                child: const Icon(Icons.arrow_forward, color: Colors.white,))
          ],
        ),
      ),
    );
  }
}
