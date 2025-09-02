import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    print('프로필 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: AppBar(title: Text('프로필')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              smallSize: 12,
              backgroundColor: Colors.red,
              child: Icon(Icons.person, size: 100, color: Colors.purple),
            ),
            SizedBox(height: 20),
            Text('프로필 페이지', style: TextStyle(fontSize: 24)),
            Text('첫 클릭 시 로드됨', style: TextStyle(fontSize: 16, color: Colors.orange)),
            SizedBox(height: 10),
            Text('새 알림!', style: TextStyle(fontSize: 16, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
