// Import library bawaan Flutter dan dua screen lainnya
import 'package:flutter/material.dart';
import 'package:todoapp/addScreen.dart'; // Halaman untuk menambahkan todo baru
import 'package:todoapp/loginScreen.dart'; // Halaman login untuk logout atau back

// HomeScreen adalah halaman utama, pakai StatefulWidget karena ada state yang bisa berubah (todo list, search, filter)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //list untuk bottom bar
  int myIndex = 0;
  List<Widget> widgetlist = [
    Text('Home', style: TextStyle(fontSize: 40)),
    Text('Profile', style: TextStyle(fontSize: 40)),
  ];

  // Data dummy todo list, disimpan sebagai List Map untuk memuat lebih dari satu atribut per todo
  List<Map<String, dynamic>> todos = [
    {
      'title': 'Belanja bulanan',
      'isFavorite': false, // Apakah todo ini diberi tanda favorit
      'items': [
        'Beras 5 kg',
        'Sayur',
        'Buah',
        'Minyak 2 liter',
      ], // Subtask dalam todo
    },
    {
      'title': 'Persiapan Acara',
      'isFavorite': true,
      'items': [
        'Dekor ruangan',
        'Order catering',
        'Sebar undangan',
        'Bersih-bersih',
      ],
    },
  ];

  String filter = 'Semua'; // Menyimpan status filter aktif: Semua atau Favorite
  String searchQuery = ''; // Kata kunci dari input pencarian

  @override
  Widget build(BuildContext context) {
    // Warna utama aplikasi (pastel green untuk background dan greenText untuk teks utama)
    final Color pastelGreen = const Color(0xFFCDEAC0);
    final Color greenText = const Color(0xFF3F6B3F);

    // Proses penyaringan todos berdasarkan filter dan searchQuery
    final filteredTodos =
        (filter == 'Semua'
                ? todos // Jika filter "Semua", tampilkan semua
                : todos.where(
                  (todo) =>
                      todo['isFavorite'] ==
                      true, // Jika filter "Favorite", ambil yang favorit saja
                ))
            .where(
              (todo) => todo['title'].toLowerCase().contains(
                searchQuery
                    .toLowerCase(), // Pencocokan kata kunci pencarian, tidak case-sensitive
              ),
            )
            .toList(); // Ubah hasil jadi List

    return Scaffold(
      //kerangka utama halaman, terdiri dari 'AppBar', 'FloatingActionButton', dan 'body'
      backgroundColor: const Color(
        0xFFF7FFF7,
      ), // Warna background keseluruhan halaman
      appBar: AppBar(
        backgroundColor: greenText, // Warna AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Tombol untuk kembali ke halaman login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        title: const Text(
          'PlanPaw',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Judul berada di tengah
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: pastelGreen,
        onPressed: () {
          // Ketika tombol tambah ditekan, navigasi ke halaman AddScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.green), // Ikon tambah
      ),
      body: LayoutBuilder(
        //LayoutBuilder dan Konten Utama
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting kepada user
                Text(
                  "Hello, Christian!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: greenText,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Got something to plan today?",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),

                // Search bar untuk mencari todo berdasarkan judul
                Container(
                  decoration: BoxDecoration(
                    color: pastelGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery =
                            value; // Set nilai pencarian saat user mengetik
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...', // Placeholder
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Filter chip untuk memilih tampilan: semua todo atau hanya yang favorit
                Row(
                  children: [
                    FilterChip(
                      selected: filter == 'Semua',
                      label: const Text('Semua'),
                      selectedColor: pastelGreen,
                      onSelected: (_) {
                        setState(() {
                          filter = 'Semua'; // Ganti filter ke semua
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      selected: filter == 'Favorite',
                      label: const Text('Favorite'),
                      selectedColor: pastelGreen,
                      onSelected: (_) {
                        setState(() {
                          filter = 'Favorite'; // Ganti filter ke favorit
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // GridView untuk menampilkan todo dalam bentuk grid, responsif sesuai lebar layar
                Expanded(
                  child: GridView.count(
                    crossAxisCount:
                        constraints.maxWidth >
                                600 //ika lebar layar > 600, akan tampil 3 kolom, jika tidak, 2 kolom untuk hp
                            ? 3
                            : 2,
                    childAspectRatio:
                        0.85, // Perbandingan lebar dan tinggi tiap card
                    crossAxisSpacing: 16, // Jarak horizontal antar card
                    mainAxisSpacing: 16, // Jarak vertikal antar card
                    children:
                        filteredTodos.map((todo) {
                          return Container(
                            decoration: BoxDecoration(
                              color: pastelGreen,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Judul todo + tombol favorite (icon)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        todo['title'], // Tampilkan judul
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: greenText,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        todo['isFavorite']
                                            ? Icons.favorite
                                            : Icons
                                                .favorite_border, // Icon favorit toggle
                                        color: greenText,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          todo['isFavorite'] =
                                              !todo['isFavorite']; // Toggle status favorit
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // List sub-item (subtask) dalam todo
                                ...List.generate(
                                  (todo['items'] as List).length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons
                                              .check_box_outline_blank, // Icon checklist (belum dicentang)
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            todo['items'][index], // Tampilkan nama item
                                            style: TextStyle(color: greenText),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(), // Ubah hasil map ke list widget
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
