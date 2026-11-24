import 'package:flutter/material.dart';

import '../core/format.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/app_store.dart';
import '../models/data.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});

  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  static const _jenis = ['Sakit', 'Izin', 'Keperluan keluarga'];

  final _store = AppStore.instance;
  final _ketCtrl = TextEditingController();
  DateTime? _tanggal;
  String? _jenisDipilih;

  @override
  void dispose() {
    _ketCtrl.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? now,
      firstDate: now.subtract(const Duration(days: 7)),
      lastDate: now.add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _tanggal = picked);
  }

  void _kirim() {
    if (_tanggal == null ||
        _jenisDipilih == null ||
        _ketCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lengkapi semua data pengajuan')));
      return;
    }
    // TODO: kirim pengajuan ke API sekolah.
    _store.tambahIzin(
        LeaveRequest(_tanggal!, _jenisDipilih!, _ketCtrl.text.trim()));
    setState(() {
      _tanggal = null;
      _jenisDipilih = null;
      _ketCtrl.clear();
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Pengajuan terkirim')));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _store,
      builder: (context, _) {
        return AppPage(
          title: 'Perizinan',
          subtitle: 'Pengajuan dan riwayat izin',
          showBack: true,
          children: [
            const SectionTitle('AJUKAN IZIN'),
            const FormLabel('Tanggal izin'),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: _pilihTanggal,
              child: InputDecorator(
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                ),
                child: Text(
                  _tanggal == null
                      ? 'Pilih tanggal'
                      : tanggalLengkap(_tanggal!),
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        _tanggal == null ? AppColors.muted : AppColors.ink,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const FormLabel('Jenis izin'),
            DropdownButtonFormField<String>(
              // ignore: deprecated_member_use
              value: _jenisDipilih,
              hint: const Text('Sakit / Izin / Keperluan keluarga',
                  style: TextStyle(color: AppColors.muted, fontSize: 13)),
              items: [
                for (final j in _jenis)
                  DropdownMenuItem(value: j, child: Text(j)),
              ],
              onChanged: (v) => setState(() => _jenisDipilih = v),
            ),
            const SizedBox(height: 16),
            const FormLabel('Keterangan'),
            TextField(
              controller: _ketCtrl,
              maxLines: 3,
              decoration:
                  const InputDecoration(hintText: 'Tuliskan alasan izin'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
                onPressed: _kirim, child: const Text('KIRIM PENGAJUAN')),
            const SectionTitle('RIWAYAT PENGAJUAN'),
            if (_store.izin.isEmpty)
              const EmptyCard(title: 'Belum ada pengajuan izin')
            else
              for (final r in _store.izin)
                InfoCard(
                  leading: const IconBox(
                    icon: Icons.edit_note,
                    color: AppColors.amber,
                    background: AppColors.amberSoft,
                  ),
                  title: '${r.jenis} • ${tanggalPendek(r.tanggal)}',
                  subtitle: r.keterangan,
                  trailing: const Pill('MENUNGGU'),
                ),
          ],
        );
      },
    );
  }
}