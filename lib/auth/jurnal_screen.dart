import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';

class JurnalScreen extends StatelessWidget {
  const JurnalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPage(
      title: 'Jurnal PKL',
      subtitle: 'Catatan kegiatan praktik kerja lapangan',
      showBack: true,
      children: [
        AppCard(
          color: AppColors.tealSoft,
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'STATUS PERIODE PKL',
                  style: TextStyle(
                    color: AppColors.teal,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Periode PKL belum dimulai',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        SectionTitle('JURNAL KEGIATAN'),
        EmptyCard(
          title: 'Belum ada jurnal yang dapat diisi',
          message:
              'Jurnal akan aktif otomatis setelah periode PKL dimulai oleh sekolah.',
        ),
      ],
    );
  }
}