import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/holder/add/widgets/add_body.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('추가 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: _appbar(context),
      body: AddBody(),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text('미니그램 만들기'),
      centerTitle: true,
    );
  }
}
