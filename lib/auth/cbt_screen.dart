import 'package:flutter/material.dart';

import '../core/widgets.dart';

class CbtScreen extends StatelessWidget {
  const CbtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPage(
      title: 'CBT',
      subtitle: 'Computer Based Test',
      showBack: true,
      children: [
        SectionTitle('UJIAN SAYA'),
        EmptyCard(
          title: 'Belum ada ujian aktif',
          message: 'Ujian yang tersedia akan ditampilkan di sini.',
        ),
        SectionTitle('RIWAYAT UJIAN'),
        EmptyCard(title: 'Belum ada riwayat ujian'),
      ],
    );
  }
}