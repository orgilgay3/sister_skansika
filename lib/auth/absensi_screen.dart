import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/app_store.dart';
import '../models/data.dart';

class AbsensiScreen extends StatelessWidget {
  final VoidCallback? onSeeAll;

  const AbsensiScreen({super.key, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final store = AppStore.instance;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final status = !store.sudahMasuk
            ? 'Belum presensi'
            : store.sudahPulang
                ? 'Masuk ${store.jamMasuk} - Pulang ${store.jamPulang}'
                : 'Presensi masuk ${store.jamMasuk}';

        return AppPage(
          title: 'Absensi',
          subtitle: 'Presensi dan rekap kehadiran',
          children: [
            AppCard(
              color: AppColors.tealSoft,
              child: Row(
                children: [
                  const IconBox(
                    icon: Icons.badge_outlined,
                    color: AppColors.teal,
                    background: Colors.white,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'STATUS HARI INI',
                          style: TextStyle(
                            color: AppColors.teal,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          status,
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.presensi),
              child: const Text('BUKA ABSENSI WAJAH'),
            ),
            SectionTitle('REKAP OKTOBER', onSeeAll: onSeeAll),
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    child: Column(
                      children: [
                        Text(
                          '${rekapOktober.hadir}',
                          style: const TextStyle(
                            color: AppColors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text('Hadir',
                            style: TextStyle(
                                color: AppColors.muted, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppCard(
                    child: Column(
                      children: [
                        Text(
                          '${rekapOktober.izin}',
                          style: const TextStyle(
                            color: AppColors.amber,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Text('Izin',
                            style: TextStyle(
                                color: AppColors.muted, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SectionTitle('RIWAYAT TERBARU'),
            for (final record in riwayatPresensi.take(5))
              InfoCard(
                leading: IconBox(
                  icon: record.status == 'Hadir'
                      ? Icons.check
                      : Icons.edit_note,
                  color: record.status == 'Hadir'
                      ? AppColors.green
                      : AppColors.amber,
                  background: AppColors.blueSoft,
                ),
                title: record.tanggal,
                subtitle: 'Tercatat pada sistem sekolah',
                trailing: Pill(record.status),
              ),
          ],
        );
      },
    );
  }
}
