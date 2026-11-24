import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'core/theme.dart';
import 'auth/cbt_screen.dart';
import 'auth/izin_screen.dart';
import 'auth/jurnal_screen.dart';
import 'auth/login_screen.dart';
import 'auth/main_shell.dart';
import 'auth/menu_semua_screen.dart';
import 'auth/notifikasi_screen.dart';
import 'auth/presensi_screen.dart';
import 'auth/riwayat_screen.dart';

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
        AppRoutes.main: (_) => const MainShell(),
        AppRoutes.presensi: (_) => const PresensiScreen(),
        AppRoutes.riwayat: (_) => const RiwayatScreen(),
        AppRoutes.izin: (_) => const IzinScreen(),
        AppRoutes.cbt: (_) => const CbtScreen(),
        AppRoutes.jurnal: (_) => const JurnalScreen(),
        AppRoutes.notifikasi: (_) => const NotifikasiScreen(),
        AppRoutes.menuSemua: (_) => const MenuSemuaScreen(),
      },
    );
  }
}