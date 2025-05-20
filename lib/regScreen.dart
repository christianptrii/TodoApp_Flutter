// Import library Flutter dan eksternal
import 'package:flutter/material.dart';
import 'package:todoapp/loginScreen.dart'; // Import halaman login untuk navigasi
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Package untuk ikon Google

// StatefulWidget karena akan ada perubahan UI (toggle password)
class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  // Untuk mengatur apakah password disembunyikan atau tidak
  bool _obscurePassword = true;

  // Warna-warna tema yang konsisten di seluruh halaman
  final Color pastelGreen = const Color(0xFFCDEAC0);
  final Color greenText = const Color(0xFF3F6B3F);
  final Color bgColor = const Color(
    0xFFF7FFF7,
  ); // (belum dipakai di UI tapi bisa untuk pengembangan ke depan)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pastelGreen, // Warna latar belakang seluruh halaman
      body: SingleChildScrollView(
        // Supaya konten bisa discroll (penting untuk responsif)
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0, // Padding kiri-kanan
            vertical: 100.0, // Padding atas (untuk space header)
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Posisi konten rata kiri
            children: [
              const Text(
                'Create Your\nAccount', // Judul halaman dengan line break
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF3F6B3F),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 60), // Spasi antara judul dan input field
              // Label "Full Name" di atas kolom
              Text(
                'Full Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: greenText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // TextField untuk nama lengkap
              TextField(
                decoration: InputDecoration(
                  filled: true, // Field diisi background
                  fillColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.check,
                    color: greenText,
                  ), // Ikon validasi (sementara statis)
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut membulat
                  ),
                ),
              ),

              const SizedBox(height: 20), // Spasi antar input
              // Label "Email" di atas kolom
              Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: greenText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // TextField untuk email
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.check, color: greenText),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Label "Password" di atas kolom
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: greenText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // TextField untuk password dengan toggle visibility
              TextField(
                obscureText: _obscurePassword, // Toggle visibilitas password
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    // Ikon bisa ditekan untuk toggle visibilitas
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword; // Toggle password show/hide
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Teks "Already have an account?" dan tombol Sign In
              Align(
                alignment: Alignment.centerRight, // Geser ke kanan
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Supaya row-nya selebar konten aja
                  children: [
                    const Text(
                      "Already have an account? ", // Teks statis
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman login saat ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign in", // Teks interaktif
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Tombol SIGN UP (belum ada aksi, hanya UI)
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Di sini nantinya logika SIGN UP akan ditambahkan
                  },
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          greenText,
                          const Color(0xFF264D26),
                        ], // Gradasi hijau gelap
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Section login dengan Google
              Center(
                child: Column(
                  children: [
                    Text(
                      'Or sign up with Google', // Teks info
                      style: TextStyle(fontSize: 17, color: greenText),
                    ),
                    const SizedBox(height: 12),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                      ), // Ikon Google
                      color: greenText,
                      iconSize: 30,
                      onPressed: () {
                        // Di sini nanti tambahkan fungsi login dengan Google
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30), // Spasi akhir
            ],
          ),
        ),
      ),
    );
  }
}
