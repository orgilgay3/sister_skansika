import 'package:flutter/material.dart';

import '../core/routes.dart';
import 'absensi_screen.dart';
import 'home_screen.dart';
import 'jadwal_screen.dart';
import 'lms_screen.dart';
import 'profil_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = AppTabs.beranda;

  void _goTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(onGoTab: _goTab),
      const JadwalScreen(),
      const LmsScreen(),
      AbsensiScreen(onSeeAll: () => Navigator.of(context)
          .pushNamed(AppRoutes.riwayat)),
      const ProfilScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFE8E8F0))),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: _goTab,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda'),
            NavigationDestination(
                icon: Icon(Icons.grid_on), label: 'Jadwal'),
            NavigationDestination(
                icon: Icon(Icons.view_list_outlined), label: 'LMS'),
            NavigationDestination(
                icon: Icon(Icons.check), label: 'Absensi'),
            NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profil'),
          ],
        ),
      ),
    );
  }
}