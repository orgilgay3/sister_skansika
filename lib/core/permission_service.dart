import 'package:permission_handler/permission_handler.dart';

enum HasilIzin { diberikan, ditolak, ditolakPermanen }

class PermissionService {
  PermissionService._();

  static Future<HasilIzin> lokasi() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted || status.isLimited) return HasilIzin.diberikan;
    if (status.isPermanentlyDenied || status.isRestricted) {
      return HasilIzin.ditolakPermanen;
    }
    return HasilIzin.ditolak;
  }

  static Future<bool> bukaPengaturan() => openAppSettings();
}
