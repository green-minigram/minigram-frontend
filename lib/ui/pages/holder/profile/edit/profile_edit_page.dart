import 'package:flutter/material.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/profile/edit/widgets/profile_edit_header.dart';
import 'package:minigram/ui/pages/holder/profile/edit/widgets/profile_edit_list_item.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Divider(),
          ProfileEditHeader(),
          Divider(),
          ProfileEditListItem(title: "이름", subtitle: "", trailingUrl: MRoute.profileEditName),
          Divider(),
          ProfileEditListItem(title: "사용자 이름", subtitle: "ssar"),
          Divider(),
          ProfileEditListItem(title: "소개", subtitle: "", trailingUrl: MRoute.profileEditBio),
          Divider(),
          ProfileEditListItem(title: "연락처 정보", subtitle: "ssar@nate.com"),
          Divider(),
          ProfileEditListItem(title: "생일", subtitle: "", trailingUrl: MRoute.profileEditBirthDate),
          Divider(),
          ProfileEditListItem(title: "성별", subtitle: "", trailingUrl: MRoute.profileEditGender),
          Divider(),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text("프로필 편집"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
