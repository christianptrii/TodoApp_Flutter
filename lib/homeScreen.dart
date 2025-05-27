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
      'title': 'Belanja bulanan',
      'isFavorite': false,
      'category': 'Makanan',
      'items': ['Beras 5 kg', 'Sayur', 'Buah', 'Minyak 2 liter'],
      'collaborators': ['A', 'B'],
    },
    {
      'title': 'Persiapan Acara',
      'isFavorite': true,
      'category': 'Pekerjaan',
      'items': [
        'Dekor ruangan',
        'Order catering',
        'Sebar undangan',
        'Bersih-bersih',
      ],
      'collaborators': ['C'],
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
  ];

  @override
  Widget build(BuildContext context) {
    final Color pastelGreen = const Color(0xFFCDEAC0);
    final Color greenText = const Color(0xFF3F6B3F);

    final filteredTodos =
        todos.where((todo) {
          if (filter == 'Semua') {
            return todo['title'].toLowerCase().contains(
              searchQuery.toLowerCase(),
            );
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                    children:
                        categories.map((cat) {
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
              Expanded(
                child: GridView.count(
                  crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
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
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      todo['isFavorite']
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: greenText,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        todo['isFavorite'] =
                                            !todo['isFavorite'];
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ...List.generate(
                                (todo['items'] as List).length,
                                (index) => Padding(
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
                                          todo['items'][index],
                                          style: TextStyle(color: greenText),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children:
                                    (todo['collaborators'] as List).map<Widget>(
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
                                                fontSize: 12,
                                                color: Colors.white,
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
            ],
          ),
        );
      },
    );

    final profileContent = const ProfileScreen();

    return Scaffold(
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
      floatingActionButton:
          myIndex == 0
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
      body: IndexedStack(
        index: myIndex,
        children: [homeContent, profileContent],
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
    );
  }
}
