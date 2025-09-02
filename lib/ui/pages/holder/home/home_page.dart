import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    print('홈 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: AppBar(title: Text('홈')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text('홈 페이지', style: TextStyle(fontSize: 24)),
            Text('처음 로드됨', style: TextStyle(fontSize: 16, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
