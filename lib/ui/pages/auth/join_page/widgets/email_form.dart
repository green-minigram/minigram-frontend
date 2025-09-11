import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/auth/join_page/join_fm.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class EmailForm extends ConsumerWidget {
  const EmailForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    JoinFM fm = ref.read(joinProvider.notifier);
    JoinModel model = ref.watch(joinProvider);

    return Form(
      child: ListView(
        children: [
          SizedBox(height: MSize.kGap.l),
          MAuthTextFormField(
            title: "이메일",
            hintText: "이메일을 입력해주세요",
            keyboardType: TextInputType.emailAddress,
            errorText: model.emailError,
            onChanged: fm.email,
            isChecking: model.isEmailChecking,
            isAvailable: model.isEmailAvailable,
          ),
          SizedBox(height: MSize.kGap.l),
          MButton(
            onPressed: fm.confirmEmail,
            text: "다음",
          ),
        ],
      ),
    );
  }
}
