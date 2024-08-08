import 'package:flutter/material.dart';
import 'reservation_page.dart';
import 'club_page.dart';
import 'profile_page.dart';
import 'menu_page.dart';
import 'my_table_tennis.dart';
import 'resume.dart';
import 'lesson.dart';
import 'contest.dart';
import 'notification_page.dart';
import 'setting_page.dart';

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
          backgroundColor: Colors.black,
          selectedLabelStyle: TextStyle(fontSize: 14),
          unselectedLabelStyle: TextStyle(fontSize: 14),
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedIconTheme: IconThemeData(size: 24),
          unselectedIconTheme: IconThemeData(size: 24),
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
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
            }, icon: Icon(Icons.notifications, size: 30,),),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage()));
            }, icon: Icon(Icons.settings, size: 30),),
          ],
        ),
        body: switch (currentItem) {
          0 => MainBody(),
          1 => ReservationPage(),
          2 => ClubPage(),
          3 => ProfilePage(),
          4 => MenuPage(),
          _ => MainBody()
        },

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
              label: '동호회',
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
            height: 100,
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MyTableTennis()));},
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
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Resume()));},
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
                          'Resume',
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
            ),),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Lesson()));},
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
            ),),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Contest()));},
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
            ),),
        ],
        ));
  }
}
