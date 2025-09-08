import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/setting/widgets/setting_admin.dart';
import 'package:minigram/ui/pages/holder/profile/setting/widgets/setting_login.dart';
import 'package:minigram/ui/pages/holder/profile/setting/widgets/setting_my_account.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
        child: Column(
          spacing: MSize.kGap.xl,
          children: [
            SettingMyAccount(),
            SettingLogin(),
            SettingAdmin(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: const Text("설정 및 활동"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
