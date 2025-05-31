import 'package:flutter/material.dart';
import 'package:todoapp/addScreen.dart';
import 'package:todoapp/profileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;
  String selectedCategory = 'Semua';
  String searchQuery = '';

  final Color pastelGreen = const Color(0xFFCDEAC0);
  final Color greenText = const Color(0xFF3F6B3F);

  final List<Map<String, dynamic>> todos = [
    {
      'title': 'Belanja Bulanan',
      'isFavorite': false,
      'category': 'Makanan',
      'items': [
        'Beras 5 kg',
        'Sayur kol',
        'Apel 1 kg',
        'Minyak 2 liter',
        'Jeruk 1 kg',
      ],
      'collaborators': ['A', 'B'],
    },
    {
      'title': 'Persiapan Acara Kantor',
      'isFavorite': true,
      'category': 'Pekerjaan',
      'items': [
        'Dekor ruangan',
        'Order catering',
        'Sebar undangan',
        'Bersih-bersih',
      ],
      'collaborators': ['C', 'D'],
    },
    {
      'title': 'Tugas Kuliah',
      'isFavorite': true,
      'category': 'Studi',
      'items': ['Baca jurnal AI', 'Tugas matematika', 'Presentasi'],
      'collaborators': ['E'],
    },
    {
      'title': 'Plan Keuangan',
      'isFavorite': false,
      'category': 'Keuangan',
      'items': ['Bayar listrik', 'Cek anggaran', 'Tabung 20% gaji'],
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
      'items': ['Piknik', 'Tiket bioskop', 'Makan malam keluarga'],
      'collaborators': ['J', 'K', 'L'],
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'label': 'Semua', 'icon': Icons.grid_view},
    {'label': 'Favorite', 'icon': Icons.favorite},
    {'label': 'Pekerjaan', 'icon': Icons.work},
    {'label': 'Makanan', 'icon': Icons.fastfood},
    {'label': 'Studi', 'icon': Icons.school},
    {'label': 'Keuangan', 'icon': Icons.attach_money},
    {'label': 'Kreatif', 'icon': Icons.brush},
    {'label': 'Kesehatan', 'icon': Icons.favorite_outline},
    {'label': 'Pribadi', 'icon': Icons.person},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredTodos =
        todos.where((todo) {
          final titleMatch = todo['title'].toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
          if (selectedCategory == 'Semua') return titleMatch;
          if (selectedCategory == 'Favorite')
            return todo['isFavorite'] && titleMatch;
          return todo['category'] == selectedCategory && titleMatch;
        }).toList();

    final homeContent = LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                decoration: BoxDecoration(
                  color: greenText,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, Christian!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Got something to plan today?",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ],
                ),
              ),

              // Kategori Scroll
              Container(
                height: 100,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = selectedCategory == cat['label'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat['label'];
                        });
                      },
                      child: Container(
                        width: 85,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? pastelGreen : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                isSelected ? greenText : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              cat['icon'],
                              color: isSelected ? greenText : Colors.grey,
                              size: 24,
                            ),
                            const SizedBox(height: 6),
                            Flexible(
                              child: Text(
                                cat['label'],
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isSelected ? greenText : Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: pastelGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Todo Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
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
                              // Title + Favorite
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        todo['isFavorite'] =
                                            !todo['isFavorite'];
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Items (max 4)
                              ...List.generate(
                                (todo['items'] as List).length > 4
                                    ? 4
                                    : (todo['items'] as List).length,
                                (i) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.check_box_outline_blank,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          todo['items'][i],
                                          style: TextStyle(color: greenText),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),

                              // Collaborators
                              Row(
                                children:
                                    (todo['collaborators'] as List).take(3).map(
                                      (initial) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 6,
                                          ),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: greenText,
                                            child: Text(
                                              initial,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF7),
      floatingActionButton:
          myIndex == 0
              ? FloatingActionButton(
                backgroundColor: pastelGreen,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddScreen()),
                  );
                },
                child: const Icon(Icons.add, color: Colors.green),
              )
              : null,
      body: SafeArea(
        child: IndexedStack(
          index: myIndex,
          children: [homeContent, const ProfileScreen()],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: myIndex,
          onTap: (index) => setState(() => myIndex = index),
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
