import 'package:flutter/material.dart';

import '../core/format.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class RiwayatScreen extends StatelessWidget {
  const RiwayatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Riwayat Presensi',
      subtitle: 'Seluruh catatan kehadiran',
      showBack: true,
      children: [
        const SectionTitle('OKTOBER 2025'),
        if (riwayatPresensi.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Belum ada catatan kehadiran.'),
            ),
          )
        else
          for (final r in riwayatPresensi)
            InfoCard(
              leading: IconBox(
                icon: r.status == 'Hadir' ? Icons.check : Icons.edit_note,
                color: r.status == 'Hadir' ? AppColors.green : AppColors.amber,
                background: AppColors.blueSoft,
              ),
              title: r.tanggal,
              subtitle: 'Tercatat pada sistem sekolah',
              trailing: statusPill(r.status),
            ),
      ],
    );
  }
}