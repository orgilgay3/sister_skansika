import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  void _dataDiri(BuildContext context) => showInfoSheet(
        context,
        title: 'Data diri siswa',
        children: const [
          InfoRow('Nama lengkap', 'Raditia Ardiansyah'),
          InfoRow('NIS', '10231'),
          InfoRow('Sekolah', 'SMK Negeri 1 Bukateja', last: true),
        ],
      );

  void _infoKelas(BuildContext context) => showInfoSheet(
        context,
        title: 'Informasi kelas',
        children: const [
          InfoRow('Kelas', 'XI RPL 1'),
          InfoRow('Jurusan', 'Rekayasa Perangkat Lunak', last: true),
        ],
      );

  void _pengaturan(BuildContext context) => showInfoSheet(
        context,
        title: 'Pengaturan akun',
        children: const [
          InfoRow('Username', '10231'),
          InfoRow('Kata sandi', 'Hubungi pengelola akun', last: true),
        ],
      );

  void _bantuan(BuildContext context) => showInfoSheet(
        context,
        title: 'Bantuan aplikasi',
        children: const [
          Text(
            'Jika mengalami kendala login, presensi, atau tugas, hubungi '
            'pengelola akun atau wali kelas di SMK Negeri 1 Bukateja.',
            style: TextStyle(fontSize: 13.5, height: 1.4),
          ),
          SizedBox(height: 12),
          Text('SISTER SKANSIKA • Versi 1.0',
              style: TextStyle(color: AppColors.muted, fontSize: 11.5)),
        ],
      );

  Future<void> _keluar(BuildContext context) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Keluar',
                  style: TextStyle(color: AppColors.red))),
        ],
      ),
    );
    if (yakin == true && context.mounted) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final menu = <(String, VoidCallback)>[
      ('Data diri siswa', () => _dataDiri(context)),
      ('Informasi kelas', () => _infoKelas(context)),
      ('Pengaturan akun', () => _pengaturan(context)),
      ('Bantuan aplikasi', () => _bantuan(context)),
      ('Keluar', () => _keluar(context)),
    ];

    return AppPage(
      title: 'Profil Siswa',
      subtitle: 'Informasi akun peserta didik',
      children: [
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.tealSoft,
              borderRadius: BorderRadius.circular(28),
            ),
            child: const Icon(Icons.person_outline,
                size: 56, color: AppColors.blue),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            student.nama,
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            'NIS ${student.nis}  •  ${student.kelas}',
            style: const TextStyle(color: AppColors.muted, fontSize: 11.5),
          ),
        ),
        const SizedBox(height: 28),
        for (final (title, onTap) in menu)
          InfoCard(
            leading: IconBox(
              icon: title == 'Keluar' ? Icons.logout : Icons.chevron_right,
              color: title == 'Keluar' ? AppColors.red : AppColors.blue,
              background: AppColors.blueSoft,
            ),
            title: title,
            subtitle: title == 'Keluar'
                ? 'Akhiri sesi di perangkat ini'
                : 'Lihat dan kelola informasi',
            onTap: onTap,
          ),
      ],
    );
  }
}