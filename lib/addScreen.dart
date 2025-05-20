import 'package:flutter/material.dart';
import 'package:todoapp/homeScreen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController titleController = TextEditingController();
  List<TextEditingController> checklistControllers = [TextEditingController()];
  List<bool> isCheckedList = [false];

  final Color pastelGreen = const Color(0xFFCDEAC0);
  final Color greenText = const Color(0xFF3F6B3F);
  final Color bgColor = const Color(0xFFF7FFF7);

  @override
  void dispose() {
    titleController.dispose();
    for (var controller in checklistControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void addChecklistField() {
    setState(() {
      checklistControllers.add(TextEditingController());
      isCheckedList.add(false);
    });
  }

  void submit() {
    String title = titleController.text;
    List<String> items =
        checklistControllers
            .map((controller) => controller.text)
            .where((item) => item.isNotEmpty)
            .toList();

    if (title.isEmpty || items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan content tidak boleh kosong!')),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _showCollaboratorDialog(BuildContext context) {
    List<String> collaborators = [
      'gekina01@gmail.com (Owner)',
      'christianprtii@gmail.com',
      'indiratrij@gmail.com',
    ];
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Collaborators',
                style: TextStyle(color: greenText, fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...collaborators.map((email) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: greenText.withOpacity(0.1),
                          child: Icon(Icons.person, color: greenText),
                        ),
                        title: Text(
                          email,
                          style: TextStyle(
                            color: greenText,
                            fontWeight:
                                email.contains('Owner')
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                        ),
                        trailing:
                            email.contains('Owner')
                                ? null
                                : IconButton(
                                  icon: Icon(Icons.close, color: greenText),
                                  onPressed: () {
                                    setState(() {
                                      collaborators.remove(email);
                                    });
                                  },
                                ),
                      );
                    }).toList(),
                    const Divider(),
                    TextField(
                      controller: emailController,
                      cursorColor: greenText,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_add, color: greenText),
                        hintText: 'Person or email to share with',
                        hintStyle: TextStyle(color: greenText.withOpacity(0.6)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greenText),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: greenText.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: greenText)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: greenText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      setState(() {
                        collaborators.add(emailController.text);
                        emailController.clear();
                      });
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                'Checklist Rencana',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: greenText,
                ),
              ),
              const SizedBox(height: 8),
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
                        Checkbox(
                          value: isCheckedList[index],
                          onChanged: (value) {
                            setState(() {
                              isCheckedList[index] = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
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
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
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
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pastelGreen,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        _showCollaboratorDialog(context);
                      },
                      child: Icon(Icons.person_add, color: greenText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
