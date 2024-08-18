import 'package:flutter/material.dart';
import 'package:pingpod/models/pingpong_court.dart';
import 'package:pingpod/main/my_table_tennis_detail.dart';

class MyTableTennis extends StatefulWidget {
  const MyTableTennis({super.key});

  @override
  State<MyTableTennis> createState() => _MyTableTennisState();
}

class _MyTableTennisState extends State<MyTableTennis> {
  final List<PingPongCourt> courts = [
    PingPongCourt(
      name: '탁구장 A',
      users: ['User 1', 'User 2', 'User 3'],
      cctvUrl: 'http://example.com/cctv_a',
      location: '서울특별시 강남구 A동 123',
    ),
    PingPongCourt(
      name: '탁구장 B',
      users: ['User 4', 'User 5'],
      cctvUrl: 'http://example.com/cctv_b',
      location: '서울특별시 강남구 B동 456',
    ),
    PingPongCourt(
      name: '탁구장 C',
      users: ['User 6', 'User 7', 'User 8'],
      cctvUrl: 'http://example.com/cctv_c',
      location: '서울특별시 강남구 C동 789',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 탁구장 보기'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: courts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(
                courts[index].name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(courts[index].location),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourtDetailPage(court: courts[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}