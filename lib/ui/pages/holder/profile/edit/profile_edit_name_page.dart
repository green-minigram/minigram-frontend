import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileEditNamePage extends StatelessWidget {
  const ProfileEditNamePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이름"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(MSize.kLine.normal),
          child: Container(
            color: Colors.grey,
            height: MSize.kLine.normal,
          ),
        ),
      ),
    );
  }
}
