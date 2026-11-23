/// Pemformat tanggal & jam berbahasa Indonesia (tanpa paket intl).
const _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
const _bulan = [
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

String two(int n) => n.toString().padLeft(2, '0');

/// 1 = Senin ... 7 = Minggu
String namaHari(int weekday) => _hari[weekday - 1];

String namaBulan(int month) => _bulan[month - 1];

/// Contoh: Senin, 27 Oktober 2025
String tanggalLengkap(DateTime d) =>
    '${namaHari(d.weekday)}, ${d.day} ${namaBulan(d.month)} ${d.year}';

/// Contoh: 27/10/2025
String tanggalPendek(DateTime d) => '${two(d.day)}/${two(d.month)}/${d.year}';

/// Contoh: 07.00
String jamMenit(DateTime d) => '${two(d.hour)}.${two(d.minute)}';

String salamWaktu(DateTime d) {
  final h = d.hour;
  if (h < 11) return 'Selamat pagi';
  if (h < 15) return 'Selamat siang';
  if (h < 18) return 'Selamat sore';
  return 'Selamat malam';
}