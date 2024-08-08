import 'package:flutter/material.dart';

class Lesson extends StatefulWidget {
  const Lesson({super.key});

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar:AppBar(title: Text('Lesson'),), body:Center(child:Text('레슨 신청 페이지입니다.')));
  }
}
