import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/gvm/session_gvm.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/auth/login_page/login_fm.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class LoginForm extends ConsumerWidget {
  final Future<void> Function()? onFieldTapped;

  const LoginForm({
    this.onFieldTapped,
    super.key,
  });

  // 로그인 버튼의 onPressed 이벤트를 위한 함수
  void _onLoginPressed(context) {
    Navigator.pushNamedAndRemoveUntil(context, MRoute.mainHolder, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoginFM fm = ref.read(loginProvider.notifier);
    LoginModel model = ref.watch(loginProvider);

    // 세션 상태에서 로딩 여부 watch
    SessionGVM sessionGvm = ref.read(sessionProvider.notifier);
    SessionModel session = ref.watch(sessionProvider);
    bool isLoggingIn = session.isLoggingIn ?? false;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MAuthTextFormField(
            hintText: "이메일",
            keyboardType: TextInputType.emailAddress,
            onTap: onFieldTapped,
            onChanged: fm.email,
            errorText: model.emailError,
          ),
          SizedBox(height: MSize.kGap.l),
          MAuthTextFormField(
            hintText: "비밀번호",
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            onTap: onFieldTapped,
            onChanged: fm.password,
            errorText: model.passwordError,
          ),
          SizedBox(height: MSize.kGap.l),
          MButton(
            text: "로그인",
            isLoading: isLoggingIn,
            onPressed: () {
              sessionGvm.login(model.email, model.password);
            },
          ),
          SizedBox(height: MSize.kGap.l),
        ],
      ),
    );
  }
}
