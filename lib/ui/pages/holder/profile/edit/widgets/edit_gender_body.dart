import 'package:flutter/material.dart';
import 'package:minigram/_core/enums/gender_type.dart';

class EditGenderBody extends StatelessWidget {
  GenderType? _character = GenderType.male;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
