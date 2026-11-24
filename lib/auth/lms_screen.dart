import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class LmsScreen extends StatefulWidget {
  const LmsScreen({super.key});

  @override
  State<LmsScreen> createState() => _LmsScreenState();
}

class _LmsScreenState extends State<LmsScreen> {
  int _tab = 0;

  void _detail(LmsItem item) {
    showInfoSheet(
      context,
      title: item.judul,
      children: [
        Text(item.keterangan,
            style: const TextStyle(color: AppColors.muted, fontSize: 12)),
        const SizedBox(height: 14),
        Text(item.deskripsi, style: const TextStyle(fontSize: 13.5)),
        const SizedBox(height: 14),
        // TODO: hubungkan unduh materi / pengumpulan tugas ke LMS sekolah.
        const Text(
          'Unduh materi dan pengumpulan tugas belum terhubung ke server sekolah.',
          style: TextStyle(color: AppColors.muted, fontSize: 11.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _tab == 0 ? daftarTugas : daftarMateri;

    return AppPage(
      title: 'Materi & LMS',
      subtitle: 'Pusat tugas dan materi belajar',
      children: [
        TabStrip(
          tabs: const ['Tugas Aktif', 'Materi'],
          selected: _tab,
          onChanged: (i) => setState(() => _tab = i),
        ),
        const SizedBox(height: 4),
        for (final item in items)
          InfoCard(
            leading: const IconBox(
              icon: Icons.view_list_outlined,
              color: AppColors.blue,
              background: AppColors.blueSoft,
            ),
            title: item.judul,
            subtitle: item.keterangan,
            trailing: const Pill('DETAIL'),
            onTap: () => _detail(item),
          ),
      ],
    );
  }
}