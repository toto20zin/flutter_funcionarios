import 'package:flutter/material.dart';
import 'package:flutter_funcionario/ui/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  void irParaHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Funcionários")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 👇 AQUI A MÁGICA
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/icone.png',
                width: 150,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: irParaHome,
              child: const Text("Entrar"),
            ),
          ],
        ),
      ),
    );
  }
}