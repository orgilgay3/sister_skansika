import 'package:flutter/material.dart';
import 'package:sister_skansika/auth/routes.dart';
import 'package:sister_skansika/auth/theme.dart';

import 'screens/login_screen.dart';

void main() => runApp(const SisterApp());

class SisterApp extends StatelessWidget {
  const SisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SISTER SKANSIKA',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
       
      },
    );
  }
}