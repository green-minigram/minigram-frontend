import 'package:flutter/material.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/profile/edit/widgets/edit_header.dart';
import 'package:minigram/ui/pages/holder/profile/edit/widgets/edit_list_item.dart';
import 'package:minigram/ui/widgets/m_app_bar_bottom_line.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        children: [
          EditHeader(),
          Divider(),
          EditListItem(title: "이름", subtitle: "", trailingUrl: MRoute.profileEditName),
          Divider(),
          EditListItem(title: "사용자 이름", subtitle: "ssar"),
          Divider(),
          EditListItem(title: "소개", subtitle: "", trailingUrl: MRoute.profileEditBio),
          Divider(),
          EditListItem(title: "연락처 정보", subtitle: "ssar@nate.com"),
          Divider(),
          EditListItem(title: "생일", subtitle: "", trailingUrl: MRoute.profileEditBirthDate),
          Divider(),
          EditListItem(title: "성별", subtitle: "", trailingUrl: MRoute.profileEditGender),
          Divider(),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text("프로필 편집"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      bottom: const MAppBarBottomLine(),
    );
  }
}
