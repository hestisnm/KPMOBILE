import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class NilaiMuridPage extends StatefulWidget {
  @override
  _NilaiMuridPageState createState() => _NilaiMuridPageState();
}

class _NilaiMuridPageState extends State<NilaiMuridPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedKelas;
  final nisController = TextEditingController();
  final namaController = TextEditingController();
  bool _isLoading = false;

  List<Map<String, dynamic>> hasilPencarian = [];
  String filterStatus = 'Semua';
  String cariKuis = "";

  final Map<String, List<Map<String, dynamic>>> dataNilaiMurid = {
    "Kelas 7-12345": [
      {"judul": "Kuis Matematika 1", "status": "Sudah", "nilai": 85},
      {"judul": "Kuis IPA 1", "status": "Sudah", "nilai": 90},
      {"judul": "Kuis Bahasa Indonesia 1", "status": "Belum", "nilai": null},
      {"judul": "Kuis Matematika 2", "status": "Sudah", "nilai": 75},
      {"judul": "Kuis IPA 2", "status": "Belum", "nilai": null},
      {"judul": "Kuis Bahasa Indonesia 2", "status": "Sudah", "nilai": 88},
      {"judul": "Kuis Sejarah 1", "status": "Belum", "nilai": null},
    ],
    "Kelas 8-54321": [
      {"judul": "Kuis Matematika 2", "status": "Sudah", "nilai": 78},
      {"judul": "Kuis IPA 2", "status": "Belum", "nilai": null},
    ],
  };

  Future<void> cariNilai() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      hasilPencarian = [];
      filterStatus = "Semua";
      cariKuis = "";
    });

    await Future.delayed(Duration(seconds: 2));

    String nis = nisController.text.trim();
    String kelas = selectedKelas!;
    String key = "$kelas-$nis";

    if (dataNilaiMurid.containsKey(key)) {
      hasilPencarian = dataNilaiMurid[key]!;
    } else {
      hasilPencarian = [];
    }

    setState(() {
      _isLoading = false;
    });

    if (hasilPencarian.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Data siswa tidak ditemukan atau belum ada kuis.")),
      );
    }
  }

  List<Map<String, dynamic>> get filteredList {
    var list = hasilPencarian;

    if (filterStatus != 'Semua') {
      list = list.where((kuis) => kuis['status'] == filterStatus).toList();
    }

    if (cariKuis.trim().isNotEmpty) {
      list = list
          .where((kuis) => kuis['judul']
              .toString()
              .toLowerCase()
              .contains(cariKuis.toLowerCase()))
          .toList();
    }

    return list;
  }

  double get rataRataNilai {
    var sudah = hasilPencarian
        .where((kuis) => kuis['status'] == 'Sudah' && kuis['nilai'] != null);
    if (sudah.isEmpty) return 0;
    var total = sudah.fold<int>(0, (sum, e) => sum + (e['nilai'] as int));
    return total / sudah.length;
  }

  int get jumlahSudah =>
      hasilPencarian.where((k) => k['status'] == 'Sudah').length;
  int get jumlahBelum =>
      hasilPencarian.where((k) => k['status'] == 'Belum').length;

  @override
  void dispose() {
    nisController.dispose();
    namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Nilai Murid",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedKelas,
                      decoration: InputDecoration(
                        labelText: "Pilih Kelas",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.indigo.shade50,
                      ),
                      items: ["Kelas 7", "Kelas 8", "Kelas 9"]
                          .map(
                              (k) => DropdownMenuItem(value: k, child: Text(k)))
                          .toList(),
                      onChanged: (val) => setState(() => selectedKelas = val),
                      validator: (v) => v == null ? "Pilih Kelas" : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: nisController,
                      decoration: InputDecoration(
                        labelText: "NIS (Nomor Induk Siswa)",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.indigo.shade50,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if ((value == null || value.isEmpty) &&
                            (namaController.text.trim().isEmpty)) {
                          return "Isi NIS atau Nama minimal salah satu";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: namaController,
                      decoration: InputDecoration(
                        labelText: "Nama Siswa",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.indigo.shade50,
                      ),
                      validator: (value) {
                        if ((value == null || value.isEmpty) &&
                            (nisController.text.trim().isEmpty)) {
                          return "Isi Nama atau NIS minimal salah satu";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : cariNilai,
                      icon: Icon(Icons.search),
                      label: Text("Cari Nilai"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else if (hasilPencarian.isNotEmpty) ...[
                Card(
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text("Ringkasan Performa",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 20,
                          runSpacing: 12,
                          children: [
                            _buildRingkasanItem("Kuis Sudah dikerjakan",
                                jumlahSudah.toString()),
                            _buildRingkasanItem("Kuis Belum dikerjakan",
                                jumlahBelum.toString()),
                            _buildRingkasanItem("Nilai Rata-rata",
                                rataRataNilai.toStringAsFixed(2)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      value: filterStatus,
                      items: ['Semua', 'Sudah', 'Belum']
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            filterStatus = val;
                          });
                        }
                      },
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Cari kuis",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: Colors.indigo.shade50,
                        ),
                        onChanged: (val) {
                          setState(() {
                            cariKuis = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final kuis = filteredList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: Icon(
                          kuis['status'] == 'Sudah'
                              ? Icons.check_circle
                              : Icons.pending,
                          color: kuis['status'] == 'Sudah'
                              ? Colors.green
                              : Colors.orange,
                        ),
                        title: Text(kuis['judul'],
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            "Status: ${kuis['status']}\nNilai: ${kuis['nilai'] != null ? kuis['nilai'].toString() : '-'}"),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
                if (filteredList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        "Tidak ada kuis sesuai filter dan pencarian.",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ] else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                      child: Text("Data belum dicari",
                          style: GoogleFonts.poppins())),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRingkasanItem(String title, String value) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 6),
          Text(title,
              style: GoogleFonts.poppins(fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
