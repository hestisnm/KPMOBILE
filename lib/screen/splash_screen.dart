import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelas_pintar/presentation/pages/start.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Start()), (route) => false);
    });

    return Scaffold(
      backgroundColor: const Color(0xFFEBE8FB),
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            'assets/images/splash_screen.png',
            fit: BoxFit.cover, // Sesuaikan jika perlu
          ))
        ],
      ),
    );
  }
}
