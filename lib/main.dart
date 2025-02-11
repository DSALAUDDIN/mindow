import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

void main() {
  runApp(MaterialApp(
    home: OnboardingScreen(),
    theme: ThemeData(
      primaryColor: Colors.blueGrey[900],
      // Define additional theme properties as needed
    ),
  ));
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyTabs()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Mindow",
          body: "Mindow is a psychological counseling app that helps you improve your mental health and well-being.",
          image: Image.asset('assets/onboard_page1.png'),
          decoration: PageDecoration(
            bodyTextStyle: TextStyle(fontSize: 18.0),
          ),
        ),
        PageViewModel(
          title: "Get Professional Guidance",
          body: "Connect with experienced counselors and therapists who can provide you with the support you need.",
          image: Image.asset('assets/onboard_page2.png'),
          decoration: PageDecoration(
            bodyTextStyle: TextStyle(fontSize: 18.0),
          ),
        ),
        PageViewModel(
          title: "Learn Mindfulness Techniques",
          body: "Practice mindfulness and meditation exercises to reduce stress, improve focus, and cultivate a positive mindset.",
          image: Image.asset('assets/onboard_page3.png'),
          decoration: PageDecoration(
            bodyTextStyle: TextStyle(fontSize: 18.0),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: Text("Skip"),
      next: Icon(Icons.arrow_forward),
      done: Text("Done"),
    );
  }
}

class MyTabs extends StatefulWidget {
  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          Feed(),
          Mindfulness(),
          Appointment(),
          Reading(),
          More(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.home, 'Home', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.spa, 'Mindfulness', 1),
            label: 'Mindfulness',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.event, 'Appointment', 2),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.menu_book, 'Reading', 3),
            label: 'Reading',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.more_horiz, 'More', 4),
            label: 'More',
          ),
        ],
        selectedItemColor: Color(0xFF69C2CC),
        unselectedItemColor: Color(0xFFF28775),
      ),
    );
  }

  Widget _buildTabIcon(IconData icon, String text, int index) {
    bool isSelected = index == selectedIndex;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isSelected ? _buildCircleIcon(icon) : Icon(icon, size: 24),
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF69C2CC),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  String selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    // Get the current time
    DateTime now = DateTime.now();
    int hour = now.hour;

    // Determine the appropriate greeting based on the current time
    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = selectedLanguage == 'en' ? 'Good Morning!' : 'সুপ্রভাত!';
    } else if (hour >= 12 && hour < 16) {
      greeting = selectedLanguage == 'en' ? 'Good Noon!' : 'শুভ মধ্যাহ্ন!';
    } else if (hour >= 16 && hour < 20) {
      greeting = selectedLanguage == 'en' ? 'Good Afternoon!' : 'শুভ অপরাহ্ন!';
    } else {
      greeting = selectedLanguage == 'en' ? 'Good Evening!' : 'শুভ সন্ধ্যা!';
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 20),
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 85,
                right: 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/DashboardImage.png',
                      width: 180,
                      height: 140,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  greeting,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    height: 1.2,
                    color: Color(0xFF232323),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 16.5,
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: Color(0xFFF28775),
                    ),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLanguage =
                          selectedLanguage == 'en' ? 'bn' : 'en';
                        });
                      },
                      child: Icon(
                        Icons.language,
                        size: 18,
                        color: Color(0xFFF28775),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 200,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Appointment()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF28775),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.videocam,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      'Talk with a counselor',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins_700Bold',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 160,
                      height: 24,
                      margin: EdgeInsets.only(left: 16, right: 150),
                      alignment: Alignment.center,
                      child: Text(
                        'Your mood matters',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.5,
                          letterSpacing: 0,
                          color: Color(0xFF232323),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/Wave.jpg',
                      width: 387,
                      height: 85,
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              width: 328,
                              height: 44,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF69C2CC),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white24,
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    width: 45,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color:
                                        Color.fromRGBO(242, 135, 117, 0.2),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF69C2CC),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white38,
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    width: 45,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.sentiment_dissatisfied,
                                        color:
                                        Color.fromRGBO(242, 135, 117, 0.4),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF69C2CC),
                                        width: 1,
                                      ),
                                      color: Color(0xFF69C2CC),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white30,
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    width: 45,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF69C2CC),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white38,
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    width: 45,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.sentiment_satisfied,
                                        color:
                                        Color.fromRGBO(242, 135, 117, 0.8),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color(0xFF69C2CC),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          offset: Offset(0, 3),
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    width: 45,
                                    height: 30,
                                    child: Center(
                                      child: Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Color(0xFFF28775),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: 160,
                      height: 24,
                      margin: EdgeInsets.only(left: 16, right: 150),
                      alignment: Alignment.center,
                      child: Text(
                        'Mental health tips',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 1.5,
                          letterSpacing: 0,
                          color: Color(0xFF232323),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(top: 2, left: 10, right: 10),
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reading()),
                              );
                            },
                            child: _buildCard(
                              image: 'assets/img_3.png',
                              title: 'Exercise to stay mentally fit and happy',
                              description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reading()),
                              );
                            },
                            child: _buildCard(
                              image: 'assets/img_3.png',
                              title: 'Exercise to stay mentally fit and happy',
                              description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reading()),
                              );
                            },
                            child: _buildCard(
                              image: 'assets/img_3.png',
                              title: 'Exercise to stay mentally fit and happy',
                              description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reading()),
                              );
                            },
                            child: _buildCard(
                              image: 'assets/img_3.png',
                              title: 'Exercise to stay mentally fit and happy',
                              description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reading()),
                              );
                            },
                            child: _buildCard(
                              image: 'assets/img_3.png',
                              title: 'Exercise to stay mentally fit and happy',
                              description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reading()),
                              );
                            },
                            child: _buildCard(
                              image: 'assets/img_3.png',
                              title: 'Exercise to stay mentally fit and happy',
                              description:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 144,
            height: 70,
          ),
          SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'Poppins_700Bold',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontFamily: 'Poppins_300Light',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class Mindfulness extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindfulness Page'),
      ),
      body: Center(
        child: Text(
          'Mindfulness Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Page'),
      ),
      body: Center(
        child: Text(
          'Appointment Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class Reading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Page'),
      ),
      body: Center(
        child: Text(
          'Reading Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Page'),
      ),
      body: Center(
        child: Text(
          'More Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
