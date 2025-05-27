import 'package:flutter/material.dart';
import 'package:todoapp/addScreen.dart';
import 'package:todoapp/loginScreen.dart';
import 'package:todoapp/profileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  List<Map<String, dynamic>> todos = [
    {
      'title': 'Belanja Bulanan',
      'isFavorite': false,
      'category': 'Makanan',
      'items': ['Beras 5 kg', 'Sayur kolplay', 'Apel 1 kg', 'Minyak 2 liter', 'Jeruk 1 kg'],
      'collaborators': ['A', 'B'],
    },
    {
      'title': 'Persiapan Acara Kantor',
      'isFavorite': true,
      'category': 'Pekerjaan',
      'items': ['Dekor ruangan', 'Order catering', 'Sebar undangan', 'Bersih-bersih'],
      'collaborators': ['C', 'D'],
    },
    {
      'title': 'Tugas Kuliah',
      'isFavorite': true,
      'category': 'Studi',
      'items': ['Baca jurnal AI', 'Kerjakan tugas matematika', 'Siapkan presentasi'],
      'collaborators': ['E'],
    },
    {
      'title': 'Plan Keuangan',
      'isFavorite': false,
      'category': 'Keuangan',
      'items': ['Bayar tagihan listrik', 'Cek anggaran bulanan', 'Tabung 20% gaji'],
      'collaborators': ['F'],
    },
    {
      'title': 'Proyek Desain',
      'isFavorite': true,
      'category': 'Kreatif',
      'items': ['Sketsa logo', 'Revisi mockup', 'Kirim ke klien'],
      'collaborators': ['G', 'H'],
    },
    {
      'title': 'Olahraga Mingguan',
      'isFavorite': false,
      'category': 'Kesehatan',
      'items': ['Lari 5 km', 'Yoga 30 menit', 'Gym sesi kekuatan'],
      'collaborators': ['I'],
    },
    {
      'title': 'Libur Akhir Pekan',
      'isFavorite': true,
      'category': 'Pribadi',
      'items': ['Piknik ke pantai', 'Beli tiket bioskop', 'Makan malam keluarga'],
      'collaborators': ['J', 'K', 'L'],
    },
  ];

  String filter = 'Semua';
  String searchQuery = '';

  final List<String> categories = [
    'Semua',
    'Favorite',
    'Pekerjaan',
    'Makanan',
    'Studi',
    'Keuangan',
    'Kreatif',
    'Kesehatan',
    'Pribadi',
  ];

  @override
  Widget build(BuildContext context) {
    final Color pastelGreen = const Color(0xFFCDEAC0);
    final Color greenText = const Color(0xFF3F6B3F);

    final filteredTodos = todos.where((todo) {
      if (filter == 'Semua') {
        return todo['title'].toLowerCase().contains(searchQuery.toLowerCase());
      } else if (filter == 'Favorite') {
        return todo['isFavorite'] == true &&
            todo['title'].toLowerCase().contains(searchQuery.toLowerCase());
      } else {
        return todo['category'] == filter &&
            todo['title'].toLowerCase().contains(searchQuery.toLowerCase());
      }
    }).toList();

    final homeContent = LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            selected: filter == cat,
                            label: Text(cat),
                            selectedColor: pastelGreen,
                            onSelected: (_) {
                              setState(() {
                                filter = cat;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: pastelGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: filteredTodos.map((todo) {
                    return SizedBox(
                      width: 160, // Lebar tetap untuk setiap kartu
                      height: 280, // Tinggi diperpanjang untuk memanjang ke bawah
                      child: Container(
                        decoration: BoxDecoration(
                          color: pastelGreen,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    todo['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: greenText,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1, // Batasi judul 1 baris
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    todo['isFavorite']
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: greenText,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      todo['isFavorite'] = !todo['isFavorite'];
                                    });
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    (todo['items'] as List).length > 5
                                        ? 5
                                        : (todo['items'] as List).length, // Batasi maksimal 5 item
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_box_outline_blank,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              todo['items'][index],
                                              style: TextStyle(color: greenText),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1, // Batasi item 1 baris
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: (todo['collaborators'] as List)
                                  .take(3) // Batasi maksimal 3 collaborator
                                  .map<Widget>(
                                    (initial) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 6),
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: greenText,
                                          child: Text(
                                            initial,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );

    final profileContent = const ProfileScreen();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // Menetapkan textScaleFactor ke 1.0
      child: Scaffold(
        backgroundColor: const Color(0xFFF7FFF7),
        appBar: AppBar(
          backgroundColor: greenText,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
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
          centerTitle: true,
        ),
        floatingActionButton: myIndex == 0
            ? FloatingActionButton(
                backgroundColor: pastelGreen,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddScreen()),
                  );
                },
                child: const Icon(Icons.add, color: Colors.green),
              )
            : null,
        body: SafeArea(
          child: IndexedStack(
            index: myIndex,
            children: [homeContent, profileContent],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: myIndex,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          selectedItemColor: greenText,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}