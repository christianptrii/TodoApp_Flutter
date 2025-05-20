// Import library yang dibutuhkan
import 'package:flutter/material.dart';
import 'package:todoapp/loginScreen.dart'; // Untuk navigasi ke halaman Login
import 'package:todoapp/regScreen.dart'; // Untuk navigasi ke halaman Register

// Class stateless widget untuk Welcome Screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Warna-warna yang digunakan di halaman ini
    final Color pastelGreen = const Color(0xFFCDEAC0); // Warna latar belakang
    final Color greenText = const Color(0xFF3F6B3F); // Warna teks utama

    return Scaffold(
      backgroundColor: pastelGreen, // Set warna latar belakang
      body: SafeArea(
        // Menghindari area yang tertutup (notch, status bar, dll)
        child: SingleChildScrollView(
          // Supaya halaman bisa discroll kalau content-nya panjang
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 180,
            ), // Padding atas dan bawah
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .center, // Posisi elemen di tengah horizontal
              children: [
                // Gambar ilustrasi aplikasi
                Center(
                  child: SizedBox(
                    width:
                        MediaQuery.of(context).size.width *
                        0.5, // Setengah dari lebar layar
                    child: Image.asset(
                      'assets/imagetodo.png', // Gambar dari assets
                      fit:
                          BoxFit
                              .contain, // Menyesuaikan gambar agar tidak terpotong
                    ),
                  ),
                ),

                const SizedBox(height: 60), // Spasi setelah gambar
                // Judul aplikasi
                Text(
                  'Plan Paw',
                  style: TextStyle(
                    fontSize: 30,
                    color: greenText,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30), // Spasi setelah judul
                // Tombol SIGN IN
                GestureDetector(
                  onTap: () {
                    // Navigasi ke LoginScreen ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        30,
                      ), // Bikin ujung tombol membulat
                      border: Border.all(
                        color: greenText,
                      ), // Garis pinggir hijau
                    ),
                    child: Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: greenText,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30), // Spasi setelah tombol sign in
                // Tombol SIGN UP
                GestureDetector(
                  onTap: () {
                    // Navigasi ke RegScreen ketika tombol ditekan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 53,
                    width: 320,
                    decoration: BoxDecoration(
                      color: greenText, // Background tombol hijau
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Teks putih di tombol hijau
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40), // Jarak bawah
              ],
            ),
          ),
        ),
      ),
    );
  }
}
