import 'package:flutter/material.dart';

import '../core/location_service.dart';
import '../core/permission_service.dart';
import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/app_store.dart';

/// Absensi wajah: presensi masuk lalu presensi pulang.
class PresensiScreen extends StatefulWidget {
  const PresensiScreen({super.key});

  @override
  State<PresensiScreen> createState() => _PresensiScreenState();
}

class _PresensiScreenState extends State<PresensiScreen> {
  final _store = AppStore.instance;
  bool _memindai = false;
  LokasiAbsen? _lokasiTerakhir;

  Future<bool> _izinLokasiOk() async {
    final hasil = await PermissionService.lokasi();
    if (hasil == HasilIzin.diberikan) return true;
    if (!mounted) return false;

    if (hasil == HasilIzin.ditolakPermanen) {
      final buka = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Izin lokasi diperlukan'),
          content: const Text(
            'Aktifkan izin lokasi lewat Pengaturan agar presensi dapat dilakukan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Buka Pengaturan'),
            ),
          ],
        ),
      );
      if (buka == true) await PermissionService.bukaPengaturan();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin lokasi diperlukan untuk presensi')),
      );
    }
    return false;
  }

  Future<void> _mulai() async {
    setState(() => _memindai = true);
    try {
      if (!await _izinLokasiOk()) return;
      final lokasi = await LocationService.ambil();
      await Future<void>.delayed(const Duration(seconds: 2));
      if (!mounted) return;

      final pulang = _store.sudahMasuk;
      _store.catatPresensi(DateTime.now());
      setState(() => _lokasiTerakhir = lokasi);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${pulang ? 'Presensi pulang' : 'Presensi masuk'} tercatat'
            ' • ${lokasi.koordinat}',
          ),
        ),
      );
    } on LokasiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.pesan)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Presensi gagal. Periksa izin dan coba lagi.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _memindai = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _store,
      builder: (context, _) {
        final selesai = _store.sudahMasuk && _store.sudahPulang;
        final label = selesai
            ? 'PRESENSI HARI INI SELESAI'
            : (_store.sudahMasuk ? 'PRESENSI PULANG' : 'PRESENSI MASUK');

        final status = !_store.sudahMasuk
            ? 'Belum presensi hari ini'
            : (_store.sudahPulang
                  ? 'Masuk ${_store.jamMasuk} • Pulang ${_store.jamPulang}'
                  : 'Presensi masuk tercatat • ${_store.jamMasuk}');

        return AppPage(
          title: 'Absensi Wajah',
          subtitle: 'Presensi masuk dan pulang',
          showBack: true,
          children: [
            AppCard(
              color: AppColors.tealSoft,
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'STATUS KEHADIRAN HARI INI',
                      style: TextStyle(
                        color: AppColors.teal,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      status,
                      style: const TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    if (_lokasiTerakhir != null) ...[
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.teal,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${_lokasiTerakhir!.alamat}\n'
                              '${_lokasiTerakhir!.koordinat} • '
                              'akurasi ±${_lokasiTerakhir!.akurasi.round()} m',
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SectionTitle('VERIFIKASI WAJAH'),
            Center(
              child: Container(
                width: 260,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: _memindai ? AppColors.teal : AppColors.border,
                    width: _memindai ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_memindai)
                      const SizedBox(
                        width: 56,
                        height: 56,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: AppColors.teal,
                        ),
                      )
                    else
                      Icon(
                        selesai
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        size: 64,
                        color: selesai ? AppColors.green : AppColors.teal,
                      ),
                    const SizedBox(height: 16),
                    Text(
                      _memindai
                          ? 'Memverifikasi wajah…'
                          : (selesai
                                ? 'Terima kasih, sampai jumpa besok!'
                                : 'Posisikan wajah di dalam bingkai'),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (_memindai || selesai) ? null : _mulai,
              child: Text(label),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.riwayat),
              child: const Text(
                'Lihat riwayat presensi',
                style: TextStyle(
                  color: AppColors.teal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Catatan: lokasi diambil dari perangkat; kamera dan verifikasi '
                'wajah masih berupa simulasi.',
                style: TextStyle(color: AppColors.muted, fontSize: 11.5),
              ),
            ),
          ],
        );
      },
    );
  }
}
