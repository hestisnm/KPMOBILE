import 'package:flutter/material.dart';

class DashboardGuruPage extends StatefulWidget {
  final String namaGuru;
  final String emailGuru; // identitas unik guru

  const DashboardGuruPage({
    super.key,
    required this.namaGuru,
    required this.emailGuru,
  });

  @override
  State<DashboardGuruPage> createState() => _DashboardGuruPageState();
}

class _DashboardGuruPageState extends State<DashboardGuruPage> {
  // Contoh semua kuis dari semua guru
  List<Map<String, dynamic>> semuaKuis = [
    {
      'judul': 'Kuis Matematika Dasar',
      'jumlahSoal': 10,
      'mataPelajaran': 'Matematika',
      'dibuatOleh': 'guru1@example.com'
    },
    {
      'judul': 'Kuis Biologi',
      'jumlahSoal': 8,
      'mataPelajaran': 'IPA',
      'dibuatOleh': 'guru2@example.com'
    },
    {
      'judul': 'Kuis Aljabar',
      'jumlahSoal': 5,
      'mataPelajaran': 'Matematika',
      'dibuatOleh': 'guru1@example.com'
    },
  ];

  String? filterPelajaran;

  List<String> getMataPelajaranUnik(List<Map<String, dynamic>> kuis) {
    return kuis
        .where((k) => k['dibuatOleh'] == widget.emailGuru)
        .map((k) => k['mataPelajaran'].toString())
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // Filter kuis hanya yang dibuat oleh guru login
    List<Map<String, dynamic>> kuisSaya = semuaKuis
        .where((k) => k['dibuatOleh'] == widget.emailGuru)
        .toList();

    // Jika difilter berdasarkan pelajaran
    if (filterPelajaran != null) {
      kuisSaya = kuisSaya
          .where((k) => k['mataPelajaran'] == filterPelajaran)
          .toList();
    }

    final pelajaranList = getMataPelajaranUnik(semuaKuis);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Guru'),
        backgroundColor: Color.fromARGB(255, 174, 179, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, ${widget.namaGuru} 👩‍🏫',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/buatKuis');
              },
              icon: Icon(Icons.add),
              label: Text('Buat Kuis Baru'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 174, 179, 234),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Filter Mata Pelajaran:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            DropdownButton<String>(
              value: filterPelajaran,
              hint: Text('Semua Mata Pelajaran'),
              isExpanded: true,
              items: pelajaranList
                  .map((pel) => DropdownMenuItem(
                        value: pel,
                        child: Text(pel),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  filterPelajaran = value;
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: kuisSaya.isEmpty
                  ? Center(child: Text('Belum ada kuis'))
                  : ListView.builder(
                      itemCount: kuisSaya.length,
                      itemBuilder: (context, index) {
                        final kuis = kuisSaya[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            title: Text(kuis['judul']),
                            subtitle: Text(
                                '${kuis['mataPelajaran']} - ${kuis['jumlahSoal']} Soal'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.pushNamed(context, '/detailKuis');
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
