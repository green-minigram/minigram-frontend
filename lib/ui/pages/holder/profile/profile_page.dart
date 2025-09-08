import 'package:flutter/material.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_body.dart';

class ProfilePage extends StatelessWidget {
  final bool isMe = true;

  const ProfilePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ProfileBody(isMe: isMe),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('유저아이디'),
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.pushNamed(context, MRoute.profileSetting);
          },
        ),
      ],
    );
  }
}
