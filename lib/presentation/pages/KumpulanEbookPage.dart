import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Membaca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Book Reader',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Times New Roman',
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: EBookReaderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EBookReaderScreen extends StatefulWidget {
  @override
  _EBookReaderScreenState createState() => _EBookReaderScreenState();
}

class _EBookReaderScreenState extends State<EBookReaderScreen> 
    with TickerProviderStateMixin {
  
  int currentChapter = 0;
  int currentPage = 0;
  bool showMenu = false;
  double fontSize = 16.0;
  double lineHeight = 1.6;
  
  late AnimationController _menuController;
  late AnimationController _pageController;
  late Animation<double> _menuAnimation;
  late Animation<Offset> _pageSlideAnimation;

  // Book data structure
  List<Chapter> chapters = [
    Chapter(
      title: "How To Be a Real Man...",
      pages: [
        BookPage(
          chapterTitle: "Chapter 1",
          pageTitle: "Broken Ribs",
          content: '''That summer, while her boy are on vacation with their father, she goes to visit her lover in Berlin.

"You see," he says, staring down toward her and lowering his voice so that those passing by won't hear, "one thing you don't know about me is that I like to serve."

It is a surprising thing to hear, coming from a man two meters tall and built like a heavyweight. In fact, he is built exactly like a heavyweight boxer for many years, until he broke something in his back of Schwartznegger-of-vertebrae—briefly hospitalized him, turned up as a real boxer, and now works out as a personal trainer. And yet, though he claims that he will never step foot in the ring again and though he is employed as a trainer at a highly respected newspaper, the girl privately refers to him, both to her friends and to herself, as the German Boxer. It is easier than his name, which means "little gift from the god" because of that.''',
        ),
        BookPage(
          chapterTitle: "Chapter 1",
          pageTitle: "Broken Ribs",
          content: '''He tells her this while they are walking through the Tiergarten, past the pond where the ducks gather, their heads tucked under wings in the afternoon sun. She had been thinking about what he said about serving, trying to understand what he meant.

"What do you mean by that?" she asks, though she thinks she might know.

"I mean," he says, stopping to face her, his large hands gentle on her shoulders, "that I want to take care of you. I want to make sure you have everything you need."

The way he says it, so earnestly, makes her heart skip. There is something about his earnestness that moves her, though she cannot quite put her finger on what it is.

They continue walking, and she thinks about the men in her life: her husband, who is kind but distant; her lover before this one, who was passionate but unreliable; and now this man, who seems to offer something different entirely.''',
        ),
        BookPage(
          chapterTitle: "Chapter 1",
          pageTitle: "The Proposal",
          content: '''Later that evening, as they sit in his small apartment overlooking the courtyard, he makes her an offer that surprises her.

"Come live with me," he says simply. "Leave everything behind and come live with me."

She looks around his apartment: the neat stack of books on the table, the single photograph of his mother on the mantelpiece, the sparse but clean furniture. It is the apartment of a man who has learned to live with very little but has made that little beautiful.

"I can't," she says, though part of her wants to.

"Why not?"

"Because I have children. Because I have a life. Because I have responsibilities."

He nods, as if he expected this answer. "Then I will wait," he says. "I will wait until you are ready."

The certainty in his voice frightens her a little. It is not the kind of thing men usually say to her.''',
        ),
      ],
    ),
    Chapter(
      title: "How To Be a Real Man...",
      pages: [
        BookPage(
          chapterTitle: "Chapter 2",
          pageTitle: "The Decision",
          content: '''Three weeks later, she finds herself packing a small suitcase. Not because she has decided to leave everything behind, but because she needs time to think, and thinking, she has discovered, is easier when you are somewhere else.

Her husband is traveling for work again. The children are with their grandparents for the week. It seems like the perfect opportunity to disappear for a few days, to see what it might feel like to live a different kind of life.

She tells no one where she is going. She simply leaves a note saying she needs some time alone, and then she takes the train to Berlin.

He is waiting for her at the station, though she did not tell him she was coming. Somehow, he knew. This both disturbs and reassures her.

"I knew you would come," he says, taking her suitcase. 

"How?"

"Because you are braver than you think you are."''',
        ),
        BookPage(
          chapterTitle: "Chapter 2", 
          pageTitle: "Living Together",
          content: '''For five days, they live together like a real couple. He makes her coffee in the morning and asks what she would like for dinner. He runs her a bath when she comes home from walking around the city. He listens when she talks about her fears about the future.

"You don't have to decide anything right now," he tells her on the third night, as they lie in bed listening to the rain against the windows. "You can take as much time as you need."

But she knows that time is not really what she needs. What she needs is courage, and courage, she is beginning to understand, is not something that comes with time. It is something that comes with decision.

On the morning of the sixth day, she wakes up before him and watches him sleep. His face, so serious when he is awake, looks peaceful, almost boyish. She realizes that she has never seen him look anything but serious, except when he sleeps.''',
        ),
        BookPage(
          chapterTitle: "Chapter 2",
          pageTitle: "The Return",
          content: '''She leaves while he is still sleeping, not because she is afraid to say goodbye, but because she knows that if she sees his face when she tells him she is leaving, she might not be able to go.

She leaves a note on the kitchen table: "Thank you for showing me what it means to be cared for. I will never forget these days. But I have to go back to my life now. Please understand."

On the train back home, she stares out the window at the passing landscape and wonders if she has made the right choice. The rational part of her mind says yes, of course she has. She has children, responsibilities, a life that many people would consider good.

But there is another part of her mind, a smaller but more insistent voice, that whispers: What if this was your chance? What if this was your one opportunity to be truly happy, and you just walked away from it?

She does not know the answer to this question. She supposes she never will.''',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    _menuController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    
    _pageController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    
    _menuAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
    ));
    
    _pageSlideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeOutCubic,
    ));
    
    _pageController.forward();
  }

  @override
  void dispose() {
    _menuController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < chapters[currentChapter].pages.length - 1) {
      setState(() {
        currentPage++;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    } else if (currentChapter < chapters.length - 1) {
      setState(() {
        currentChapter++;
        currentPage = 0;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    } else if (currentChapter > 0) {
      setState(() {
        currentChapter--;
        currentPage = chapters[currentChapter].pages.length - 1;
      });
      _animatePageTransition();
      HapticFeedback.lightImpact();
    }
  }

  void _animatePageTransition() {
    _pageController.reset();
    _pageController.forward();
  }

  void toggleMenu() {
    setState(() {
      showMenu = !showMenu;
    });
    
    if (showMenu) {
      _menuController.forward();
    } else {
      _menuController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPageData = chapters[currentChapter].pages[currentPage];
    
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            GestureDetector(
              onTap: () {
                if (showMenu) {
                  toggleMenu();
                }
              },
              onTapUp: (details) {
                if (!showMenu) {
                  final screenWidth = MediaQuery.of(context).size.width;
                  if (details.globalPosition.dx > screenWidth * 0.5) {
                    nextPage();
                  } else {
                    previousPage();
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    // Header
                    _buildHeader(),
                    
                    // Content
                    Expanded(
                      child: _buildContent(currentPageData),
                    ),
                    
                    // Progress indicator
                    _buildProgressIndicator(),
                  ],
                ),
              ),
            ),
            
            // Menu overlay
            if (showMenu) _buildMenuOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey[600],
                size: 18,
              ),
            ),
          ),
          Expanded(
            child: Text(
              chapters[currentChapter].title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: toggleMenu,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.more_horiz,
                color: Colors.grey[600],
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BookPage page) {
    return SlideTransition(
      position: _pageSlideAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chapter info
            Text(
              page.chapterTitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8),
            
            // Page title
            Text(
              page.pageTitle,
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 32),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  page.content,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: lineHeight,
                    color: Colors.grey[800],
                    letterSpacing: 0.1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    int totalPages = chapters.fold(0, (sum, chapter) => sum + chapter.pages.length);
    int currentPageNumber = 0;
    
    for (int i = 0; i < currentChapter; i++) {
      currentPageNumber += chapters[i].pages.length;
    }
    currentPageNumber += currentPage + 1;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(1),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: currentPageNumber / totalPages,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Text(
            '$currentPageNumber of $totalPages',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOverlay() {
    return FadeTransition(
      opacity: _menuAnimation,
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reading Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 24),
                
                // Font size slider
                _buildSliderSetting(
                  'Font Size',
                  fontSize,
                  12.0,
                  24.0,
                  (value) => setState(() => fontSize = value),
                  '${fontSize.toInt()}px',
                ),
                
                SizedBox(height: 16),
                
                // Line height slider
                _buildSliderSetting(
                  'Line Height',
                  lineHeight,
                  1.2,
                  2.0,
                  (value) => setState(() => lineHeight = value),
                  lineHeight.toStringAsFixed(1),
                ),
                
                SizedBox(height: 24),
                
                // Close button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: toggleMenu,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliderSetting(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
    String displayValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              displayValue,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.grey[600],
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.grey[700],
            overlayColor: Colors.grey[600]!.withOpacity(0.2),
            trackHeight: 2,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class Chapter {
  final String title;
  final List<BookPage> pages;
  
  Chapter({
    required this.title,
    required this.pages,
  });
}

class BookPage {
  final String chapterTitle;
  final String pageTitle;
  final String content;
  
  BookPage({
    required this.chapterTitle,
    required this.pageTitle,
    required this.content,
  });
}