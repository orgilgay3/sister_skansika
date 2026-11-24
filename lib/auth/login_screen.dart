import 'package:flutter/material.dart';

import '../core/routes.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nisCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _nisCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: panggil API login sekolah di sini.
    Navigator.of(context).pushReplacementNamed(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.teal,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 56,
                bottom: 52,
              ),
              child: const Column(
                children: [
                  LogoBox(size: 130),
                  SizedBox(height: 28),
                  Text(
                    'SISTER SKANSIKA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'SMK Negeri 1 Bukateja',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 44, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Masuk sebagai Siswa',
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Gunakan akun sekolah untuk melanjutkan',
                      style: TextStyle(color: AppColors.muted, fontSize: 12),
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      controller: _nisCtrl,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'NIS / Username',
                        prefixIcon: Icon(Icons.person_outline,
                            color: AppColors.blue, size: 20),
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'NIS / Username wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _hide,
                      onFieldSubmitted: (_) => _login(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: AppColors.blue, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hide
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                          ),
                          onPressed: () => setState(() => _hide = !_hide),
                        ),
                      ),
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Password wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('MASUK SISWA'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Lupa kata sandi?  Hubungi pengelola akun',
                      style: TextStyle(
                        color: AppColors.teal,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 90),
                    const Text(
                      'SISTER SKANSIKA  •  Versi 1.0',
                      style: TextStyle(color: AppColors.muted, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}