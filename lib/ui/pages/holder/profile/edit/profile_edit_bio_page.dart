import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/edit/widgets/profile_edit_bio_body.dart';
import 'package:minigram/ui/widgets/m_app_bar_bottom_line.dart';

class ProfileEditBioPage extends StatelessWidget {
  const ProfileEditBioPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ProfileEditBioBody(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text("소개"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            "완료",
            style: TextStyle(color: MColor.kText.blue, fontSize: MSize.kFont.xl, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      bottom: const MAppBarBottomLine(),
    );
  }
}
