import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilGuruPage extends StatelessWidget {
  final TextEditingController namaController =
      TextEditingController(text: "Bapak/Ibu Guru");
  final TextEditingController nipController =
      TextEditingController(text: "123456789");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.indigo.shade200,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          Text("Nama", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          TextField(
            controller: namaController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          Text("NIP", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          TextField(
            controller: nipController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Profil berhasil diperbarui")),
                );
              },
              icon: Icon(Icons.save),
              label: Text("Simpan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
