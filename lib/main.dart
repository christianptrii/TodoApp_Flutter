// Import library Flutter yang dibutuhkan
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'WelcomeScreen.dart'; // Import halaman WelcomeScreen yang kamu buat

// Fungsi utama saat aplikasi dijalankan
void main() {
  // Mengatur warna status bar jadi transparan (biar tampilannya lebih clean)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Menjalankan aplikasi
  runApp(const MyApp());
}

// Kelas utama aplikasi (root widget)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Menghilangkan banner "Debug" di pojok kanan atas
      theme: ThemeData(
        fontFamily:
            ('inter'), // Menggunakan font 'inter' (pastikan font-nya ditambahkan di pubspec.yaml)
        useMaterial3: true, // Mengaktifkan Material Design 3
      ),
      initialRoute: '/', // Route pertama yang dibuka saat aplikasi dijalankan
      routes: {
        '/':
            (context) =>
                const WelcomeScreen(), // Rute '/' akan membuka halaman WelcomeScreen
      },
    );
  }
}
