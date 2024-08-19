import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  List<String> profiles = [];
  List<String> recommendedProfiles = [];

  @override
  void initState() {
    super.initState();
    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('profiles').get();

    setState(() {
      profiles = querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      recommendedProfiles = profiles.take(5).toList(); // 첫 5명을 추천 프로필로 설정
    });
  }

  Future<void> createProfile(String name) async {
    await FirebaseFirestore.instance.collection('profiles').add({
      'name': name,
    });
    fetchProfiles(); // 프로필을 생성한 후 목록 갱신
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '프로필 검색',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // 프로필 추가 기능
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('새 프로필 생성'),
                    content: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: '이름 입력'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          createProfile(_nameController.text);
                          Navigator.of(context).pop();
                        },
                        child: Text('생성'),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: '이름으로 검색',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (query) {
                setState(() {
                  if (query.isEmpty) {
                    fetchProfiles();
                  } else {
                    profiles = profiles
                        .where((profile) =>
                        profile.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              '추천 프로필',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: recommendedProfiles.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        recommendedProfiles[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                      onTap: () {
                        // 프로필 클릭 시 액션 추가
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              '모든 프로필',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        profiles[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                      onTap: () {
                        // 프로필 클릭 시 액션 추가
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}