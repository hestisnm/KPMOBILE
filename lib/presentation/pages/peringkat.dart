import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/constants/color_constant.dart';
import 'package:kelas_pintar/presentation/pages/notifikasi.dart';
import 'package:kelas_pintar/presentation/widgets/page_widget.dart';

class PeringkatPage extends StatefulWidget {
  const PeringkatPage({Key? key}) : super(key: key);

  @override
  State<PeringkatPage> createState() => _PeringkatPageState();
}

class _PeringkatPageState extends State<PeringkatPage>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> allRank = [
    {'nama': 'Sunjae', 'nilai': 80, 'koin': 4600},
    {'nama': 'Surya', 'nilai': 80, 'koin': 4600},
    {'nama': 'Peter', 'nilai': 80, 'koin': 4600},
    {'nama': 'Hesti', 'nilai': 78, 'koin': 4000},
    {'nama': 'Agnes', 'nilai': 75, 'koin': 3900},
  ];

  final Map<String, dynamic> userRank = {
    'ranking': 10,
    'nama': 'Hesti',
    'nilai': 80,
    'koin': 4600,
  };

  late AnimationController _handController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    _handController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _handController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Widget _userInfo() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: ColorConstant.primary),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.asset('assets/images/user_profile.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Selamat Pagi!',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AnimatedBuilder(
                        animation: _handController,
                        child: Image.asset(
                          'assets/images/tangan.png',
                          width: 30,
                          height: 30,
                        ),
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: 0.5 *
                                math.sin(_handController.value * 2 * math.pi),
                            child: child,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Notifikasi()),
                  );
                },
                color: Colors.black,
                icon: const Icon(Icons.notifications),
              ),
            )
          ],
        ),
      );

  Widget _buildUserRank(Map<String, dynamic> user) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: const Color(0xFFF3F3F3),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(
            user['ranking'].toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(user['nama']),
        subtitle: Row(
          children: [
            const Icon(Icons.score, size: 16),
            const SizedBox(width: 4),
            Text(user['nilai'].toString()),
            const SizedBox(width: 16),
            const Icon(Icons.remove_red_eye, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text(user['koin'].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildRankCard(int rank, Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: const Color(0xFFE7DBFF),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(
            '$rank',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(data['nama']),
        subtitle: Row(
          children: [
            const Icon(Icons.score, size: 16),
            const SizedBox(width: 4),
            Text('${data['nilai']}'),
            const SizedBox(width: 16),
            const Icon(Icons.remove_red_eye, size: 16, color: Colors.amber),
            const SizedBox(width: 4),
            Text('${data['koin']}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRank = allRank
        .asMap()
        .entries
        .where((entry) => entry.value['nama']
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .map((entry) => {
              'rank': entry.key + 1,
              'data': entry.value,
            })
        .toList();

    return PageWidget(
      child: Stack(
        children: [
          Column(
            children: [
              _userInfo(),
              const SizedBox(height: 10),
              const Text(
                'Peringkat',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(top: -3),
                child: Image.asset(
                  'assets/images/win_koala.png',
                  height: 190,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          SlideTransition(
            position: _slideAnimation,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Peringkat Anda",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildUserRank(userRank),
                      const SizedBox(height: 20),
                      const Text(
                        "Cari Nama",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Masukkan nama murid...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Peringkat Semua Murid",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: filteredRank.map((item) {
                          final int rank = item['rank'] as int;
                          final Map<String, dynamic> data =
                              item['data'] as Map<String, dynamic>;
                          return _buildRankCard(rank, data);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
