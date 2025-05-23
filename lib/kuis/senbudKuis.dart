import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelas_pintar/kuis/selesaiKuis.dart';
import 'package:kelas_pintar/presentation/pages/discover_page.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MaterialApp(
    home: const QuizPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
    ),
  ));
}

class Question {
  final String text;
  final List<String> options;

  Question({required this.text, required this.options});
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [
    Question(
      text:
          'Cupidatat esse magna exercitation anim nulla. Minim non commodo aliqua et aliquip id officia non quis. Aliquip sint aliqua nostrud aliquip ad tempor. Irure aliquip ipsum amet velit. Cupidatat esse magna exercitation anim nulla. Minim non commodo aliqua et aliquip id officia non quis. Aliquip sint aliqua nostrud aliquip ad tempor. Irure aliquip ipsum amet velit.',
      options: [
        'Untuk hiburan',
        'Sebagai upacara adat',
        'Untuk olahraga',
        'Sebagai makanan'
      ],
    ),
    Question(
      text:
          'Aliqua ex eiusmod pariatur id do ipsum. Deserunt fugiat reprehenderit deserunt deserunt cillum nulla ullamco minim. Elit aliquip esse dolore id incididunt ut magna dolor fugiat ut dolore excepteur proident. Commodo et do occaecat id proident.',
      options: ['Sasando', 'Gamelan', 'Angklung', 'Kolintang'],
    ),
    Question(
      text:
          'Culpa minim enim irure sunt excepteur. Est dolore dolor veniam sunt fugiat tempor exercitation exercitation consectetur occaecat est quis. Cupidatat eiusmod cillum laboris sint velit dolor. Consequat consequat Lorem deserunt est. Ad in elit eu voluptate velit et deserunt duis aute id laborum. Ea et ullamco pariatur tempor duis commodo laborum nostrud consectetur commodo. Mollit Lorem duis ipsum aliquip in proident.',
      options: [
        'Merah dan emas',
        'Biru dan hijau',
        'Putih dan hitam',
        'Abu-abu'
      ],
    ),
    Question(
      text:
          'Siapa tokoh terkenal dalam seni rupa modern Indonesia yang dikenal dengan gaya dekoratifnya?',
      options: ['Affandi', 'Raden Saleh', 'Basuki Abdullah', 'I Nyoman Nuarta'],
    ),
  ];

  int currentQuestionIndex = 0;
  Map<int, int> selectedAnswers = {};

  void _selectAnswer(int index) {
    setState(() {
      selectedAnswers[currentQuestionIndex] = index;
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _prevQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _showSubmitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Yakin ingin menyerahkan?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Jawaban yang sudah kamu pilih akan dikumpulkan.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HasilKuisPage(
                    jawabanBenar: selectedAnswers.length,
                    jawabanSalah: questions.length - selectedAnswers.length,
                    koin: 20,
                  ),
                ),
              );
            },
            child: Text(
              'Ya, Serahkan',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final selected = selectedAnswers[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFEAE6FD),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _prevQuestion,
                  ),
                  Text(
                    'KUIS SENI BUDAYA',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showSubmitConfirmation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB8CCF3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                    ),
                    child: Text(
                      'SELESAI',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentQuestionIndex + 1}/${questions.length}',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double width = constraints.maxWidth *
                              (currentQuestionIndex + 1) /
                              questions.length;
                          return Container(
                            height: 6,
                            width: width,
                            decoration: BoxDecoration(
                              color: const Color(0xFFAEB3EA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ExpandableQuestionText(question: currentQuestion.text),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.options.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  final isSelected = selected == index;
                  return GestureDetector(
                    onTap: () => _selectAnswer(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFC7DDFB)
                            : const Color(0xFFE2DFFE),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: Text(
                        currentQuestion.options[index],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (currentQuestionIndex < questions.length - 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Soal Berikutnya',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ExpandableQuestionText extends StatefulWidget {
  final String question;

  const ExpandableQuestionText({super.key, required this.question});

  @override
  State<ExpandableQuestionText> createState() => _ExpandableQuestionTextState();
}

class _ExpandableQuestionTextState extends State<ExpandableQuestionText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question,
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Sembunyikan' : 'Baca selengkapnya',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
