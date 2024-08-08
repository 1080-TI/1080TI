import 'package:flutter/material.dart';

class MyTableTennis extends StatefulWidget {
  const MyTableTennis({super.key});

  @override
  State<MyTableTennis> createState() => _MyTableTennisState();
}

class _MyTableTennisState extends State<MyTableTennis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar:AppBar(title: Text('My Table Tennis')), body: Center(child:Text("내 탁구장 보기 페이지입니다.")));
  }
}
