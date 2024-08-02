import 'package:flutter/material.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/screen/login_screen.dart';
import 'package:flutter_app_oficina_mecanica_template/presentation/widgets/general_button.dart';


class IntroScreen extends StatelessWidget {
  static const String routeName = "/";
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            const Icon(
              Icons.car_repair_sharp,
              size: 82,
              color: Colors.black,
            ),

            const SizedBox(
              height: 25,
            ),
            //title
            const Text('Oficina Mecânica',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

            const SizedBox(
              height: 10,
            ),
            //subtitle
            const Text(
              'O melhor lugal para levar seu carro',
              style: TextStyle(
                  color: Colors.black),
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
