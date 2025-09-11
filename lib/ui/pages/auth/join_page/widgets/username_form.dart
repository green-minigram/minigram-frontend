import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/auth/join_page/join_fm.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class UsernameForm extends ConsumerWidget {
  const UsernameForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    JoinFM fm = ref.read(joinProvider.notifier);
    JoinModel model = ref.watch(joinProvider);

    return Form(
      child: ListView(
        children: [
          SizedBox(height: MSize.kGap.l),
          MAuthTextFormField(
            title: "아이디",
            hintText: "아이디를 입력해주세요",
            keyboardType: TextInputType.text,
            errorText: model.usernameError,
            onChanged: fm.username,
            isChecking: model.isUsernameChecking,
            isAvailable: model.isUsernameAvailable,
          ),
          SizedBox(height: MSize.kGap.l),
          MButton(
            onPressed: fm.confirmUsername,
            text: "다음",
          ),
        ],
      ),
    );
  }
}
