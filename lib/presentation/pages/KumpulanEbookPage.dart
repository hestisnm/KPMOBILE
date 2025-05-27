import 'package:flutter/material.dart';
class KumpulanEbookPage extends StatelessWidget {
  const KumpulanEbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kumpulan eBook')),
      body: const Center(
        child: Text('Daftar eBook akan ditampilkan di sini'),
      ),
    );
  }
}
