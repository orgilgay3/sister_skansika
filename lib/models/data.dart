import 'package:flutter/material.dart';

import '../core/routes.dart';

/// Data contoh. Ganti dengan data dari API/sistem sekolah.

class Student {
  final String nama, panggilan, nis, kelas, jurusan, sekolah;
  const Student({
    required this.nama,
    required this.panggilan,
    required this.nis,
    required this.kelas,
    required this.jurusan,
    required this.sekolah,
  });
}

const student = Student(
  nama: 'Raditia Ardiansyah',
  panggilan: 'Radit',
  nis: '10231',
  kelas: 'XI RPL 1',
  jurusan: 'Rekayasa Perangkat Lunak',
  sekolah: 'SMK Negeri 1 Bukateja',
);

// ───────────── Jadwal ─────────────
class Lesson {
  final String mapel, waktu, ruang;
  const Lesson(this.mapel, this.waktu, this.ruang);
}

/// Kunci: 1 = Senin ... 5 = Jumat.
const Map<int, List<Lesson>> jadwalMingguan = {
  1: [
    Lesson('Matematika', '07.00–08.30', 'Ruang 101'),
    Lesson('Bahasa Indonesia', '08.30–10.00', 'Ruang 102'),
    Lesson('Produktif RPL', '10.15–11.45', 'Lab RPL'),
    Lesson('PPKn', '13.15–14.45', 'Ruang 104'),
  ],
  2: [
    Lesson('Bahasa Inggris', '07.00–08.30', 'Ruang 103'),
    Lesson('Produktif RPL', '08.30–11.45', 'Lab RPL'),
  ],
  3: [
    Lesson('Matematika', '07.00–08.30', 'Ruang 101'),
    Lesson('PJOK', '08.30–10.00', 'Lapangan'),
    Lesson('Sejarah', '10.15–11.45', 'Ruang 105'),
  ],
  4: [
    Lesson('Produktif RPL', '07.00–10.00', 'Lab RPL'),
    Lesson('Bahasa Inggris', '10.15–11.45', 'Ruang 103'),
  ],
  5: [
    Lesson('Pendidikan Agama', '07.00–08.30', 'Ruang 106'),
    Lesson('Seni Budaya', '08.30–10.00', 'Ruang 107'),
  ],
};

// ───────────── LMS ─────────────
class LmsItem {
  final String judul, keterangan, deskripsi;
  const LmsItem(this.judul, this.keterangan, this.deskripsi);
}

const daftarTugas = <LmsItem>[
  LmsItem('Latihan Persamaan Linear', 'Matematika • Tenggat 25 Okt',
      'Kerjakan soal latihan persamaan linear pada buku paket halaman 45.'),
  LmsItem('Teks Eksplanasi', 'Bahasa Indonesia • Tenggat 26 Okt',
      'Tulis sebuah teks eksplanasi tentang fenomena alam pilihanmu.'),
  LmsItem('Proyek Basis Data', 'Produktif RPL • Tenggat 27 Okt',
      'Rancang ERD dan implementasikan tabel untuk studi kasus yang diberikan guru.'),
];

const daftarMateri = <LmsItem>[
  LmsItem('Modul PPKn Bab 3', 'Materi pembelajaran • PDF',
      'Modul pembelajaran PPKn Bab 3 dalam format PDF.'),
];

// ───────────── Presensi ─────────────
class AttendanceRecord {
  final String tanggal, status;
  const AttendanceRecord(this.tanggal, this.status);
}

const riwayatPresensi = <AttendanceRecord>[
  AttendanceRecord('Senin, 27 Okt', 'Hadir'),
  AttendanceRecord('Jumat, 24 Okt', 'Hadir'),
  AttendanceRecord('Kamis, 23 Okt', 'Hadir'),
  AttendanceRecord('Rabu, 22 Okt', 'Izin'),
  AttendanceRecord('Selasa, 21 Okt', 'Hadir'),
  AttendanceRecord('Senin, 20 Okt', 'Hadir'),
  AttendanceRecord('Jumat, 17 Okt', 'Hadir'),
  AttendanceRecord('Kamis, 16 Okt', 'Hadir'),
  AttendanceRecord('Rabu, 15 Okt', 'Hadir'),
  AttendanceRecord('Selasa, 14 Okt', 'Hadir'),
];

class RekapBulanan {
  final String bulan;
  final int hadir, izin, sakit, alpha;
  const RekapBulanan(this.bulan, this.hadir, this.izin, this.sakit, this.alpha);

  int get total => hadir + izin + sakit + alpha;
  int get persen => total == 0 ? 0 : (hadir * 100 / total).round();
}

const rekapOktober = RekapBulanan('OKTOBER', 19, 1, 0, 0);

// ───────────── Izin ─────────────
class LeaveRequest {
  final DateTime tanggal;
  final String jenis, keterangan;
  const LeaveRequest(this.tanggal, this.jenis, this.keterangan);
}

// ───────────── Notifikasi ─────────────
class Notif {
  final String judul, isi;
  final bool baru;
  const Notif(this.judul, this.isi, {this.baru = false});
}

const daftarNotifikasi = <Notif>[
  Notif('Pelaksanaan Ujian Tengah Semester',
      'Periksa jadwal dan ketentuan ujian melalui menu akademik.',
      baru: true),
  Notif('Tugas baru: Proyek Basis Data',
      'Produktif RPL • tenggat 27 Okt.',
      baru: true),
  Notif('Presensi masuk tercatat', 'Status kehadiranmu hari ini: Hadir.'),
];

// ───────────── Menu Utama ─────────────
class MenuEntry {
  final IconData icon;
  final String title, desc;

  /// Salah satu dari [tab] atau [route] terisi.
  final int? tab;
  final String? route;
  const MenuEntry(this.icon, this.title, this.desc, {this.tab, this.route});
}

const semuaMenu = <MenuEntry>[
  MenuEntry(Icons.radio_button_unchecked, 'Absensi Wajah',
      'Presensi masuk & pulang',
      route: AppRoutes.presensi),
  MenuEntry(Icons.grid_on, 'Jadwal Pelajaran', 'Agenda mingguan',
      tab: AppTabs.jadwal),
  MenuEntry(Icons.view_list_outlined, 'Materi & LMS', 'Tugas dan materi',
      tab: AppTabs.lms),
  MenuEntry(Icons.view_week_outlined, 'Rekap Kehadiran', 'Riwayat presensi',
      tab: AppTabs.absensi),
  MenuEntry(Icons.edit_note, 'Perizinan', 'Ajukan izin tidak hadir',
      route: AppRoutes.izin),
  MenuEntry(Icons.fact_check_outlined, 'CBT / Ujian', 'Computer Based Test',
      route: AppRoutes.cbt),
  MenuEntry(Icons.work_outline, 'Jurnal PKL', 'Catatan praktik kerja',
      route: AppRoutes.jurnal),
  MenuEntry(Icons.notifications_none, 'Notifikasi', 'Informasi terbaru',
      route: AppRoutes.notifikasi),
];