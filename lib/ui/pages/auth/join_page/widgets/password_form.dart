import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/gvm/session_gvm.dart';
import 'package:minigram/ui/pages/auth/join_page/join_fm.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class PasswordForm extends ConsumerWidget {
  const PasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    JoinFM fm = ref.read(joinProvider.notifier);
    JoinModel model = ref.watch(joinProvider);

    // 세션 상태에서 로딩 여부 watch
    final session = ref.watch(sessionProvider);
    final isJoining = session.isJoining ?? false;

    return Form(
      child: ListView(
        children: [
          SizedBox(height: MSize.kGap.l),
          MAuthTextFormField(
            title: "비밀번호",
            hintText: "비밀번호를 입력해주세요",
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            errorText: model.passwordError,
            onChanged: (value) {
              fm.password(value);
            },
          ),
          SizedBox(height: MSize.kGap.l),
          MAuthTextFormField(
            hintText: "비밀번호를 확인해주세요",
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            errorText: model.passwordConfirmError,
            onChanged: (value) {
              fm.passwordConfirm(value);
            },
          ),
          SizedBox(height: MSize.kGap.l),
          // 완료 버튼: 로딩 시 스피너 표시 + 비활성화
          MButton(
            text: "완료",
            isLoading: isJoining,
            onPressed: isJoining ? null : ref.read(sessionProvider.notifier).join,
          ),
        ],
      ),
    );
  }
}
