import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('검색 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: AppBar(title: Text('검색')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text('검색 페이지', style: TextStyle(fontSize: 24)),
            Text('첫 클릭 시 로드됨', style: TextStyle(fontSize: 16, color: Colors.orange)),
          ],
        ),
      ),
    );
  }
}
