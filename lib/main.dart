
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() { 
  runApp( 
    DevicePreview( 
      enabled: true, 
      builder: (context) => const MyApp(), 
    ), 
  ); 
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // true = Login, false = Registrasi
  bool isLogin = true;
  bool hidePassword = true;

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static const merah = Color(0xFFED1B2F);
  static const pink = Color(0xFFFFE4E7);
  static const abu = Color(0xFFFAF7F8);
  static const garis = Color(0xFFECE4E6);

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EBEC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 390),
                height: constraints.maxHeight,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 1,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 32),

                        // Ikon kamera
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3F4),
                            border: Border.all(color: pink),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: merah,
                            size: 28,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Judul halaman
                        Text(
                          isLogin
                              ? 'Selamat datang kembali!'
                              : 'Buat akun baru!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Deskripsi halaman
                        Text(
                          isLogin
                              ? 'Yuk, masuk untuk lanjut ke studio favoritmu.'
                              : 'Daftar dan mulai jelajahi studio favoritmu.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFFB5A0A5),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Tab Login dan Registrasi
                        Container(
                          height: 42,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: abu,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Row(
                            children: [
                              _buildTab('Masuk', true),
                              _buildTab('Daftar', false),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Nama lengkap hanya di halaman registrasi
                        if (!isLogin) ...[
                          _buildLabel('Nama Lengkap'),
                          const SizedBox(height: 6),
                          _buildInput(
                            controller: namaController,
                            hint: 'Nama kamu',
                          ),
                          const SizedBox(height: 13),
                        ],

                        // Email
                        _buildLabel('Email'),
                        const SizedBox(height: 6),
                        _buildInput(
                          controller: emailController,
                          hint: 'email@contoh.com',
                          email: true,
                        ),

                        const SizedBox(height: 13),

                        // Kata sandi
                        _buildLabel('Kata Sandi'),
                        const SizedBox(height: 6),
                        _buildInput(
                          controller: passwordController,
                          hint: '••••••••',
                          password: true,
                        ),

                        // Lupa kata sandi hanya di halaman login
                        if (isLogin)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                _showMessage(
                                  'Fitur lupa kata sandi belum tersedia.',
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(top: 7),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Lupa kata sandi?',
                                style: TextStyle(
                                  color: merah,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                        else
                          const SizedBox(height: 13),

                        // Tombol utama
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: merah,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: pink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: Text(
                              isLogin ? 'Masuk' : 'Daftar',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Garis pemisah
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: garis),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'atau',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFFB5A0A5),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: garis),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // Tombol Google
                        SizedBox(
                          width: double.infinity,
                          height: 41,
                          child: OutlinedButton(
                            onPressed: () {
                              _showMessage(
                                isLogin
                                    ? 'Login Google belum diaktifkan.'
                                    : 'Registrasi Google belum diaktifkan.',
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: garis),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'G',
                                  style: TextStyle(
                                    color: Color(0xFF4285F4),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  isLogin
                                      ? 'Masuk dengan Google'
                                      : 'Daftar dengan Google',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 65),

                        // Hiasan bawah
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 8, color: pink),
                            SizedBox(width: 10),
                            Icon(Icons.star, size: 7, color: merah),
                            SizedBox(width: 10),
                            Icon(Icons.add, size: 8, color: pink),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Tab Masuk dan Daftar
  Widget _buildTab(String label, bool loginTab) {
    final aktif = isLogin == loginTab;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = loginTab;
            hidePassword = true;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: aktif ? merah : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: aktif
                  ? Colors.white
                  : const Color(0xFF9F8A90),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Label kolom
  Widget _buildLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.black,
        ),
      ),
    );
  }

  // Kolom input
  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    bool email = false,
    bool password = false,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        keyboardType: email
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: password && hidePassword,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 11,
            color: Color(0xFFB5A0A5),
          ),
          filled: true,
          fillColor: abu,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: garis),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: garis),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: merah),
          ),
          suffixIcon: password
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 17,
                    color: const Color(0xFFB5A0A5),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  // Validasi tombol Masuk dan Daftar
  void _submit() {
    if (!isLogin && namaController.text.trim().isEmpty) {
      _showMessage('Nama lengkap harus diisi.');
      return;
    }

    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showMessage('Email dan kata sandi harus diisi.');
      return;
    }

    if (!emailController.text.contains('@')) {
      _showMessage('Masukkan email yang valid.');
      return;
    }

    if (passwordController.text.length < 8) {
      _showMessage('Kata sandi minimal 8 karakter.');
      return;
    }

    _showMessage(
      isLogin
          ? 'Form login berhasil diisi.'
          : 'Form registrasi berhasil diisi.',
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
