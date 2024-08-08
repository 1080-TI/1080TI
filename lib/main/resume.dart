import 'package:flutter/material.dart';

class Resume extends StatefulWidget {
  const Resume({super.key});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar:AppBar(title: Text('Resume')), body:Center(child:Text('내 정보 보기 페이지입니다.')));
  }
}
