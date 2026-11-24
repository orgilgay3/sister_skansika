import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/data.dart';

/// Semua layanan. Jika layanan berupa tab, layar ini menutup dan
/// mengembalikan indeks tab ke Beranda; selain itu membuka route-nya.
class MenuSemuaScreen extends StatelessWidget {
  const MenuSemuaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Semua Layanan',
      subtitle: 'Menu lengkap SISTER SKANSIKA',
      showBack: true,
      children: [
        for (final m in semuaMenu)
          InfoCard(
            leading: IconBox(icon: m.icon),
            title: m.title,
            subtitle: m.desc,
            trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
            onTap: () {
              if (m.tab != null) {
                Navigator.of(context).pop(m.tab);
              } else {
                Navigator.of(context).pushNamed(m.route!);
              }
            },
          ),
      ],
    );
  }
}