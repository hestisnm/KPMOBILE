import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/guru/homePageGuru.dart';
import 'package:kelas_pintar/presentation/pages/KumpulanEbookPage.dart';
import 'package:kelas_pintar/presentation/pages/bacaEbook.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class BacaEbookGuru extends StatefulWidget {
  const BacaEbookGuru({super.key});

  @override
  State<BacaEbookGuru> createState() => _BacaEbookGuruState();
}

class _BacaEbookGuruState extends State<BacaEbookGuru> {
  String selectedKelas = 'Semua';

  final List<Map<String, String>> allEbooks = [
    {
      'img': 'assets/images/ebook.png',
      'title': 'Matematika Kelas 7',
      'desc': 'Pelajari dasar-dasar aljabar dan geometri.',
      'kelas': 'Kelas 7',
    },
    {
      'img': 'assets/images/ebook.png',
      'title': 'IPA Kelas 8',
      'desc': 'Mengenal gaya, energi, dan sistem tubuh manusia.',
      'kelas': 'Kelas 8',
    },
    {
      'img': 'assets/images/ebook.png',
      'title': 'Bahasa Indonesia Kelas 9',
      'desc': 'Belajar menyusun cerita dan puisi.',
      'kelas': 'Kelas 9',
    },
    {
      'img': 'assets/images/ebook.png',
      'title': 'Bahasa Inggris Kelas 7',
      'desc': 'Basic grammar and vocabulary for beginners.',
      'kelas': 'Kelas 7',
    },
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredEbooks = selectedKelas == 'Semua'
        ? allEbooks
        : allEbooks.where((e) => e['kelas'] == selectedKelas).toList();

    return PageWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: ColorConstant.primary,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePageGuru()),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Baca Ebook',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                // Tombol tambah ebook
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    _showAddEbookDialog();
                  },
                )
              ],
            ),
          ),

          // Dropdown filter kelas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: DropdownButtonFormField<String>(
              value: selectedKelas,
              decoration: InputDecoration(
                labelText: 'Pilih Kelas',
                labelStyle: GoogleFonts.poppins(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              items: ['Semua', 'Kelas 7', 'Kelas 8', 'Kelas 9']
                  .map((kelas) => DropdownMenuItem(
                        value: kelas,
                        child: Text(kelas, style: GoogleFonts.poppins()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedKelas = value!;
                });
              },
            ),
          ),

          // List eBook
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: filteredEbooks.length,
              itemBuilder: (context, index) {
                final ebook = filteredEbooks[index];
                return _buildEbookCard(
                  context,
                  ebook['img']!,
                  ebook['title']!,
                  ebook['desc']!,
                  ebook['kelas']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEbookCard(BuildContext context, String imgPath, String title,
      String desc, String kelas) {
    Widget imageWidget;
    if (imgPath.startsWith('assets/')) {
      imageWidget =
          Image.asset(imgPath, width: 60, height: 80, fit: BoxFit.cover);
    } else {
      imageWidget =
          Image.file(File(imgPath), width: 60, height: 80, fit: BoxFit.cover);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageWidget,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(desc,
                    style: GoogleFonts.poppins(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Text(kelas,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.grey[600],
                    )),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Ganti onPressed jadi onTap
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Membaca()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: ColorConstant.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("BACA",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        _confirmDeleteEbook(title);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("HAPUS",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showAddEbookDialog() {
    final _titleController = TextEditingController();
    final _descController = TextEditingController();
    String _selectedKelas = 'Kelas 7';
    File? _pickedImage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          Future<void> _pickImageDialog() async {
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setStateDialog(() {
                _pickedImage = File(image.path);
              });
            }
          }

          return AlertDialog(
            title: Text('Tambah eBook', style: GoogleFonts.poppins()),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _pickImageDialog,
                    child: Container(
                      width: 100,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                        image: _pickedImage != null
                            ? DecorationImage(
                                image: FileImage(_pickedImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _pickedImage == null
                          ? Icon(Icons.add_a_photo,
                              size: 40, color: Colors.grey[700])
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Judul'),
                  ),
                  TextField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedKelas,
                    items: ['Kelas 7', 'Kelas 8', 'Kelas 9']
                        .map((kelas) => DropdownMenuItem(
                              value: kelas,
                              child: Text(kelas),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          _selectedKelas = value;
                        });
                      }
                    },
                    decoration: const InputDecoration(labelText: 'Kelas'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Batal'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primary,
                ),
                child: const Text('Tambah'),
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _descController.text.isNotEmpty) {
                    setState(() {
                      allEbooks.add({
                        'img': _pickedImage?.path ??
                            'assets/images/ebook.png', // default jika tidak pilih gambar
                        'title': _titleController.text,
                        'desc': _descController.text,
                        'kelas': _selectedKelas,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
      },
    );
  }

  void _confirmDeleteEbook(String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus eBook', style: GoogleFonts.poppins()),
          content: Text('Yakin ingin menghapus "$title"?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Hapus'),
              onPressed: () {
                setState(() {
                  allEbooks.removeWhere((ebook) => ebook['title'] == title);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
