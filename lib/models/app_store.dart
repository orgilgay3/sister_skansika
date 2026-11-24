import 'package:flutter/foundation.dart';

import '../core/format.dart';
import 'data.dart';

/// Penyimpan status aplikasi (sementara di memori).
/// Ganti dengan state management + API sekolah saat siap terhubung.
class AppStore extends ChangeNotifier {
  AppStore._();
  static final AppStore instance = AppStore._();

  String? jamMasuk = '07.00';
  String? jamPulang;
  final List<LeaveRequest> izin = [];

  bool get sudahMasuk => jamMasuk != null;
  bool get sudahPulang => jamPulang != null;

  /// Mencatat presensi berikutnya: masuk dulu, lalu pulang.
  void catatPresensi(DateTime waktu) {
    final jam = jamMenit(waktu);
    if (!sudahMasuk) {
      jamMasuk = jam;
    } else if (!sudahPulang) {
      jamPulang = jam;
    }
    notifyListeners();
  }

  void tambahIzin(LeaveRequest r) {
    izin.insert(0, r);
    notifyListeners();
  }
}