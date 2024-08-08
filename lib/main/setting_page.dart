import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, appBar: AppBar(title: Text('설정')), body: Center(child: Text('설정창입니다.'),));
  }
}
