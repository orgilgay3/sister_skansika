import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LokasiException implements Exception {
  final String pesan;
  const LokasiException(this.pesan);
}

class LokasiAbsen {
  final double lat;
  final double lng;
  final double akurasi;
  final String alamat;

  const LokasiAbsen(this.lat, this.lng, this.akurasi, this.alamat);

  String get koordinat =>
      '${lat.toStringAsFixed(6)}, ${lng.toStringAsFixed(6)}';
}

class LocationService {
  LocationService._();

  static final _geocoding = Geocoding();

  static Future<LokasiAbsen> ambil() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LokasiException(
        'GPS belum aktif. Aktifkan layanan lokasi lalu coba lagi.',
      );
    }

    final Position posisi;
    try {
      posisi = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (_) {
      throw const LokasiException('Lokasi tidak dapat dibaca. Coba lagi.');
    }

    return LokasiAbsen(
      posisi.latitude,
      posisi.longitude,
      posisi.accuracy,
      await _alamat(posisi.latitude, posisi.longitude),
    );
  }

  static Future<String> _alamat(double lat, double lng) async {
    try {
      final hasil = await _geocoding.placemarkFromCoordinates(lat, lng);
      if (hasil.isNotEmpty) {
        final p = hasil.first;
        final bagian = <String>[];
        for (final nilai in [
          p.street,
          p.subLocality,
          p.locality,
          p.subAdministrativeArea,
          p.administrativeArea,
        ]) {
          final teks = nilai?.trim();
          if (teks != null && teks.isNotEmpty && !bagian.contains(teks)) {
            bagian.add(teks);
          }
        }
        if (bagian.isNotEmpty) return bagian.join(', ');
      }
    } catch (_) {
      // Tetap tampilkan koordinat jika layanan geocoding tidak tersedia.
    }
    return 'Lat ${lat.toStringAsFixed(6)}, Lng ${lng.toStringAsFixed(6)}';
  }
}
