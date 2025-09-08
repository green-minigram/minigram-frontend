import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_app_bar_bottom_line.dart';

enum GenderType {
  male("MALE"),
  female("FEMALE");

  const GenderType(this.serverValue);

  final String serverValue;
}

class ProfileEditGenderPage extends StatelessWidget {
  GenderType? _character = GenderType.male;

  ProfileEditGenderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("남성"),
            trailing: Radio<GenderType>(
              value: GenderType.male,
              groupValue: _character,
              onChanged: (GenderType? value) {},
            ),
          ),
          ListTile(
            title: Text("여성"),
            trailing: Radio<GenderType>(
              value: GenderType.female,
              groupValue: _character,
              onChanged: (GenderType? value) {},
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text("성별"),
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
