import 'package:flutter/material.dart';

class MenuBox extends StatefulWidget {
  final String name;
  final Icon icon;
  final String routeName; // Adicione um campo para o nome da rota

  const MenuBox({
    super.key,
    required this.name,
    required this.icon,
    required this.routeName, // Recebe o nome da rota
  });

  @override
  _MenuBoxState createState() => _MenuBoxState();
}

class _MenuBoxState extends State<MenuBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, widget.routeName);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.blue[700] : Colors.blue[400],
              borderRadius: BorderRadius.circular(25),
              boxShadow: _isHovered
                  ? [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                widget.icon,
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
