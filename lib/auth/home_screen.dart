import 'package:flutter/material.dart';

import '../core/format.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/app_store.dart';
import '../models/data.dart';

class HomeScreen extends StatelessWidget {
  /// Dipanggil untuk berpindah tab pada bottom navigation.
  final ValueChanged<int> onGoTab;
  const HomeScreen({super.key, required this.onGoTab});

  Future<void> _open(BuildContext context, MenuEntry m) async {
    if (m.tab != null) {
      onGoTab(m.tab!);
    } else {
      await Navigator.of(context).pushNamed(m.route!);
    }
  }

  Future<void> _openMenuSemua(BuildContext context) async {
    final tab = await Navigator.of(context).pushNamed(AppRoutes.menuSemua);
    if (tab is int) onGoTab(tab);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final pelajaranHariIni = jadwalMingguan[now.weekday] ?? const <Lesson>[];
    final store = AppStore.instance;

    return Scaffold(
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          return Column(
            children: [
              AppHeader(
                title: 'SISTER SKANSIKA',
                subtitle: 'Portal akademik siswa',
                actions: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.notifications_none,
                        color: Colors.white),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AppRoutes.notifikasi),
                  ),
                ],
                bottom: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${salamWaktu(now)}, ${student.panggilan}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Semoga kegiatan belajarmu menyenangkan',
                      style: TextStyle(color: Colors.white, fontSize: 11.5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    _statusKehadiran(context, store),
                    SectionTitle('MENU UTAMA',
                        onSeeAll: () => _openMenuSemua(context)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 80,
                      ),
                      itemBuilder: (context, i) => _MenuTile(
                        entry: semuaMenu[i],
                        onTap: () => _open(context, semuaMenu[i]),
                      ),
                    ),
                    SectionTitle('PENGUMUMAN SEKOLAH',
                        onSeeAll: () => Navigator.of(context)
                            .pushNamed(AppRoutes.notifikasi)),
                    const InfoCard(
                      leading: IconBox(
                        icon: Icons.priority_high,
                        color: AppColors.amber,
                      ),
                      title: 'Pelaksanaan Ujian Tengah Semester',
                      subtitle:
                          'Periksa jadwal dan ketentuan ujian melalui menu akademik.',
                      trailing: Pill('BARU'),
                    ),
                    SectionTitle('JADWAL HARI INI',
                        onSeeAll: () => onGoTab(AppTabs.jadwal)),
                    if (pelajaranHariIni.isEmpty)
                      const EmptyCard(
                        title: 'Tidak ada jadwal hari ini',
                        message: 'Selamat berakhir pekan!',
                      )
                    else
                      for (int i = 0;
                          i < pelajaranHariIni.length && i < 3;
                          i++)
                        InfoCard(
                          leading: NumberBox(i + 1),
                          title:
                              '${pelajaranHariIni[i].mapel} • ${student.kelas}',
                          subtitle:
                              '${pelajaranHariIni[i].waktu}  |  ${pelajaranHariIni[i].ruang}',
                        ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _statusKehadiran(BuildContext context, AppStore store) {
    final String subtitle;
    final Widget pill;
    if (!store.sudahMasuk) {
      subtitle = 'Kamu belum melakukan presensi hari ini';
      pill = const Pill('BELUM',
          color: AppColors.amber, background: AppColors.amberSoft);
    } else if (!store.sudahPulang) {
      subtitle = 'Presensi masuk tercatat • ${store.jamMasuk}';
      pill = const Pill('HADIR');
    } else {
      subtitle =
          'Masuk ${store.jamMasuk} • Pulang ${store.jamPulang}';
      pill = const Pill('SELESAI',
          color: AppColors.green, background: AppColors.greenSoft);
    }

    return InfoCard(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.presensi),
      leading: const IconBox(
        icon: Icons.check,
        color: AppColors.green,
        background: AppColors.blueSoft,
      ),
      title: 'STATUS KEHADIRAN HARI INI',
      subtitle: subtitle,
      trailing: pill,
    );
  }
}

class _MenuTile extends StatelessWidget {
  final MenuEntry entry;
  final VoidCallback onTap;
  const _MenuTile({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      bottomGap: 0,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconBox(icon: entry.icon, size: 46),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Buka layanan',
                  style: TextStyle(color: AppColors.muted, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}