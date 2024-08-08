import 'package:flutter/material.dart';

class Contest extends StatefulWidget {
  const Contest({super.key});

  @override
  State<Contest> createState() => _ContestState();
}

class _ContestState extends State<Contest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar:AppBar(title: Text('Contest'),), body:Center(child:Text('대회 정보 페이지입니다.')));
  }
}
