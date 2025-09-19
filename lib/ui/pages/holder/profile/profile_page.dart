import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/data/gvm/session_gvm.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_body.dart';

class ProfilePage extends ConsumerWidget {
  final int? userId;

  const ProfilePage({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userId가 null이면 sessionGVM의 userId 사용, 아니면 전달받은 userId 사용
    final targetUserId = userId ?? ref.watch(sessionProvider).user?.userId ?? 0;

    // profile_vm 호출
    final profileModel = ref.watch(profileProvider(targetUserId));

    // 프로필 모델이 null이면 로딩 인디케이터 표시
    if (profileModel == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: _appBar(context, profileModel),
        body: ProfileBody(userId: targetUserId),
      );
    }
  }

  AppBar _appBar(BuildContext context, profileModel) {
    return AppBar(
      title: Text(profileModel?.profile.username ?? '유저아이디'),
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      actions: profileModel?.profile.isOwner == true
          ? [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Navigator.pushNamed(context, MRoute.profileSetting);
                },
              ),
            ]
          : null,
    );
  }
}
