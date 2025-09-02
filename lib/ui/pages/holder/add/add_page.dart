import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    print('추가 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: AppBar(title: Text('추가')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, size: 100, color: Colors.orange),
            SizedBox(height: 20),
            Text('추가 페이지', style: TextStyle(fontSize: 24)),
            Text('첫 클릭 시 로드됨', style: TextStyle(fontSize: 16, color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}
