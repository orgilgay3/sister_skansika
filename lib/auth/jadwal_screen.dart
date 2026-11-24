import 'package:flutter/material.dart';

import '../core/format.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

class JadwalScreen extends StatefulWidget {
  const JadwalScreen({super.key});

  @override
  State<JadwalScreen> createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  static const _hari = [1, 2, 3, 4, 5];

  late final DateTime _senin;
  late int _dipilih;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // Akhir pekan menampilkan pekan depan.
    final selisih = now.weekday <= 5 ? now.weekday - 1 : -(8 - now.weekday);
    _senin = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: selisih));
    _dipilih = now.weekday <= 5 ? now.weekday - 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final tanggal = _senin.add(Duration(days: _dipilih));
    final pelajaran = jadwalMingguan[_hari[_dipilih]] ?? const <Lesson>[];

    return AppPage(
      title: 'Jadwal Pelajaran',
      subtitle: 'Agenda pembelajaran mingguan',
      children: [
        TabStrip(
          tabs: [for (final h in _hari) namaHari(h)],
          selected: _dipilih,
          onChanged: (i) => setState(() => _dipilih = i),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
          child: Text(
            tanggalLengkap(tanggal),
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (pelajaran.isEmpty)
          const EmptyCard(title: 'Belum ada jadwal untuk hari ini')
        else
          for (int i = 0; i < pelajaran.length; i++)
            InfoCard(
              leading: NumberBox(i + 1),
              title: pelajaran[i].mapel,
              subtitle: '${pelajaran[i].waktu} • ${pelajaran[i].ruang}',
              trailing: const Pill('XI RPL 1'),
            ),
      ],
    );
  }
}