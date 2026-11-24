import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Notifikasi',
      subtitle: 'Informasi terbaru dari sekolah',
      showBack: true,
      children: [
        const SectionTitle('TERBARU'),
        for (final n in daftarNotifikasi)
          InfoCard(
            leading: IconBox(
              icon: n.baru ? Icons.priority_high : Icons.notifications_none,
              color: n.baru ? AppColors.amber : AppColors.teal,
            ),
            title: n.judul,
            subtitle: n.isi,
            trailing: n.baru ? const Pill('BARU') : null,
          ),
      ],
    );
  }
}