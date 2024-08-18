import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'reservation_page.dart';
import 'club_page.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'my_table_tennis.dart';
import 'lesson.dart';
import 'contest.dart';
import 'notification_page.dart';
import 'setting_page.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentItem = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.black,
          ),
          unselectedIconTheme: IconThemeData(
            size: 24,
            color: Colors.grey,
          ),
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: Image.asset('assets/images/pingpong.png'),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              icon: Icon(Icons.notifications, size: 30, color: Colors.grey),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
              icon: Icon(Icons.settings, size: 30, color: Colors.grey),
            ),
          ],
        ),
        body: IndexedStack(
          index: currentItem,
          children: [
            MainBody(),
            ReservationPage(),
            ClubPage(),
            ProfilePage(),
            MenuPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentItem,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: '예약',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: '클럽',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '프로필',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: '메뉴',
            ),
          ],
        ),
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  List<String> contests = [];

  @override
  void initState() {
    super.initState();
    fetchContests();
  }

  Future<void> fetchContests() async {
    try {
      final response = await http.get(Uri.parse('http://m.mypingpong.co.kr/contest/list.php'));

      if (response.statusCode == 200) {
        var document = html_parser.parse(response.body);

        var contestElements = document.querySelectorAll('.contest-list li a');
        setState(() {
          contests = contestElements.take(2).map((element) => element.text.trim()).toList();
        });
      } else {
        setState(() {
          contests = ['Error: Unable to load contests (status: ${response.statusCode})'];
        });
      }
    } catch (e) {
      setState(() {
        contests = ['Error: Failed to fetch contests'];
      });
    }
  }

  Future<void> _launchURL() async {
    const url = 'http://m.mypingpong.co.kr/contest/list.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              '대회 알림 창',
              style: TextStyle(fontSize: 30),
            ),
            height: 50,
          ),
          Container(
            height: 100,
            margin: EdgeInsets.only(left: 13, right: 13, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: contests.isNotEmpty
                    ? contests.map((contest) => Text(contest, style: TextStyle(fontSize: 16))).toList()
                    : [Text('Loading...', style: TextStyle(fontSize: 16))],
              ),
            ),
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: _launchURL, // 클릭 시 링크를 엽니다
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/contest.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Center(
                        child: Text(
                          'Contest',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTableTennis()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/my_table_tennis.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Center(
                        child: Text(
                          'My Table Tennis',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()), // ProfilePage로 이동
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/resume.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lesson()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/lesson.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Center(
                        child: Text(
                          'Lesson',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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