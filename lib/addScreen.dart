// Import library Flutter dan screen HomeScreen
import 'package:flutter/material.dart';
import 'package:todoapp/homeScreen.dart';

// AddScreen adalah halaman untuk menambahkan todo baru
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  // Controller untuk input judul
  final TextEditingController titleController = TextEditingController();

  // List controller untuk input checklist item, default-nya ada 1 input
  List<TextEditingController> checklistControllers = [TextEditingController()];

  // List untuk menyimpan status centang dari masing-masing checklist
  List<bool> isCheckedList = [false];

  // Warna tema
  final Color pastelGreen = const Color(0xFFCDEAC0);
  final Color greenText = const Color(0xFF3F6B3F);
  final Color bgColor = const Color(0xFFF7FFF7);

  // Fungsi untuk membersihkan controller saat screen dihapus dari widget tree
  @override
  void dispose() {
    titleController.dispose();
    for (var controller in checklistControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Menambahkan input field checklist baru
  void addChecklistField() {
    setState(() {
      checklistControllers.add(TextEditingController());
      isCheckedList.add(
        false,
      ); // Tambah status checklist default (belum dicentang)
    });
  }

  // Fungsi ketika tombol "Tambahkan" ditekan
  void submit() {
    String title = titleController.text;

    // Ambil isi checklist yang tidak kosong
    List<String> items =
        checklistControllers
            .map((controller) => controller.text)
            .where((item) => item.isNotEmpty)
            .toList();

    // Validasi: jika judul atau checklist kosong, tampilkan pesan
    if (title.isEmpty || items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan content tidak boleh kosong!')),
      );
      return;
    }

    // Jika valid, navigasi balik ke HomeScreen (data belum disimpan, ini dummy)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor, // Warna latar belakang screen
      appBar: AppBar(
        backgroundColor: greenText,
        centerTitle: true,
        title: const Text(
          'Tambahkan List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Kembali ke halaman sebelumnya
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          // Scroll biar gak overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input judul todo
              Text(
                'Judul Rencana',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: greenText,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: pastelGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Masukkan Judul',
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Input checklist item
              Text(
                'Checklist Rencana',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: greenText,
                ),
              ),
              const SizedBox(height: 8),

              // Daftar checklist yang bisa ditambah secara dinamis
              Column(
                children: List.generate(checklistControllers.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: pastelGreen.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        // Checkbox checklist (tidak mempengaruhi logic saat ini)
                        Checkbox(
                          value: isCheckedList[index],
                          onChanged: (value) {
                            setState(() {
                              isCheckedList[index] = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        // Input text item checklist
                        Expanded(
                          child: TextField(
                            controller: checklistControllers[index],
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masukkan item...',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              // Tombol untuk menambahkan input checklist baru
              Row(
                children: [
                  TextButton.icon(
                    onPressed: addChecklistField,
                    icon: Icon(Icons.add, color: greenText),
                    label: Text(
                      'Tambah Item',
                      style: TextStyle(color: greenText),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Tombol submit
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: submit,
                  child: const Text(
                    'Tambahkan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
