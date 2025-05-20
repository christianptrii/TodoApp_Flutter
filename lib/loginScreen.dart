// Import library Flutter dan halaman lain
import 'package:flutter/material.dart';
import 'package:todoapp/regScreen.dart'; // Untuk navigasi ke halaman Register
import 'package:todoapp/homeScreen.dart'; // Untuk navigasi ke halaman Home setelah login
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Untuk ikon Google login

// StatefulWidget karena kita ingin bisa toggle password (lihat/sembunyi)
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Boolean untuk mengatur apakah password disembunyikan atau tidak
  bool _obscurePassword = true;

  // Warna-warna utama yang digunakan di halaman ini
  final Color pastelGreen = const Color(0xFFCDEAC0);
  final Color greenText = const Color(0xFF3F6B3F);
  final Color bgColor = const Color(0xFFF7FFF7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pastelGreen, // Warna latar belakang halaman
      body: SingleChildScrollView(
        // Supaya bisa discroll saat keyboard muncul
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 140.0, // Menggeser isi konten agak ke bawah
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Isi dimulai dari kiri
            children: [
              // Teks sambutan
              const Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF3F6B3F),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 60), // Jarak ke input Gmail
              // Label Gmail di atas
              Text(
                'Gmail',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: greenText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),

              // Input field Gmail
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white, // Background putih
                  suffixIcon: Icon(
                    Icons.check,
                    color: greenText,
                  ), // Ikon centang
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut melengkung
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Label Password di atas
              Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: greenText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),

              // Input field Password
              TextField(
                obscureText: _obscurePassword, // Menyembunyikan teks password
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  // Tombol lihat/sembunyikan password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // Ubah state ketika ikon ditekan
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Teks "Don't have an account?" + tombol sign up
              Align(
                alignment: Alignment.centerRight, // Posisikan ke kanan layar
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  // Artinya row ini hanya selebar kontennya (tidak full lebar layar)
                  // Ini penting supaya isi row (teks dan link sign up) nempel bareng dan tidak tersebar
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman Register
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
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

              const SizedBox(height: 20),

              // Tombol SIGN IN
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman Home dan ganti halaman login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [greenText, const Color(0xFF264D26)],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'SIGN IN',
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

              // Teks dan tombol login pakai Google
              Center(
                child: Column(
                  children: [
                    Text(
                      'Or sign in with Google',
                      style: TextStyle(fontSize: 17, color: greenText),
                    ),
                    const SizedBox(height: 12),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      color: greenText,
                      iconSize: 30,
                      onPressed: () {
                        // Tambahkan aksi login Google di sini nanti
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20), // Spasi bawah terakhir
            ],
          ),
        ),
      ),
    );
  }
}
