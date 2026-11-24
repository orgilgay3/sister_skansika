import 'package:flutter/material.dart';

String namaHari(int hari) {
  const nama = <int, String>{
    1: 'Senin',
    2: 'Selasa',
    3: 'Rabu',
    4: 'Kamis',
    5: 'Jumat',
    6: 'Sabtu',
    7: 'Minggu',
  };
  return nama[hari] ?? '';
}

String tanggalLengkap(DateTime tanggal) {
  return '${namaHari(tanggal.weekday)}, '
      '${tanggal.day} ${_namaBulan(tanggal.month)} ${tanggal.year}';
}

String tanggalPendek(DateTime tanggal) {
  return '${tanggal.day} ${_namaBulan(tanggal.month).substring(0, 3)} '
      '${tanggal.year}';
}

String jamMenit(DateTime waktu) {
  final jam = waktu.hour.toString().padLeft(2, '0');
  final menit = waktu.minute.toString().padLeft(2, '0');
  return '$jam.$menit';
}

String salamWaktu(DateTime waktu) {
  if (waktu.hour < 11) return 'Selamat pagi';
  if (waktu.hour < 15) return 'Selamat siang';
  if (waktu.hour < 18) return 'Selamat sore';
  return 'Selamat malam';
}

Widget statusPill(String status) {
  final warna = status == 'Hadir'
      ? const Color(0xFF1FA67A)
      : const Color(0xFFE0A030);
  final latar = status == 'Hadir'
      ? const Color(0xFFDDF5EB)
      : const Color(0xFFFCF1DC);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: latar,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: warna,
        fontSize: 10,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}

String _namaBulan(int bulan) {
  const nama = <String>[
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return nama[bulan];
}
