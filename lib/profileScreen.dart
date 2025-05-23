import 'package:flutter/material.dart';
import 'package:todoapp/loginScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color pastelGreen = const Color(0xFFCDEAC0);
    final Color greenText = const Color(0xFF3F6B3F);

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Christian Putri",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "christian@gmail.com",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Menu edit profil
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.black54),
              title: const Text("Edit Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.black54),
              title: const Text("Ganti Password"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.color_lens, color: Colors.black54),
              title: const Text("Preferensi / Tema"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.black54),
              title: const Text("Tentang Aplikasi"),
              onTap: () {},
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: greenText,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
