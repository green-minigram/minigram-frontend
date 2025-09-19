import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/gvm/session_gvm.dart';
import 'package:minigram/ui/pages/holder/home/home_vm.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_image.dart';
import 'package:minigram/ui/pages/post/write/post_write_fm.dart';
import 'package:minigram/ui/pages/post/write/widgets/post_date_picker.dart';

class PostWritePage extends ConsumerStatefulWidget {
  final List<String> imagePaths;

  const PostWritePage({
    super.key,
    required this.imagePaths,
  });

  @override
  ConsumerState<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends ConsumerState<PostWritePage> {
  final TextEditingController _textController = TextEditingController();
  late List<String> _limitedImages;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    if (widget.imagePaths.length > 10) {
      _limitedImages = widget.imagePaths.take(10).toList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("알림"),
            content: Text("사진은 최대 10장까지만 업로드 가능합니다."),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("확인")),
            ],
          ),
        );
      });
    } else {
      _limitedImages = widget.imagePaths;
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final user = session.user;

    final isAdmin = (user?.roles ?? "").contains("ADMIN");

    return Scaffold(
      appBar: _appbar(context),
      body: ListView(
        children: [
          PostFormHeader(username: user?.username ?? "게스트"),
          PostFormImage(imagePaths: _limitedImages),

          if (isAdmin) ...[
            PostDatePicker(
              label: "시작일",
              selectedDate: _startDate,
              onDateChanged: (date) => setState(() => _startDate = date),
            ),
            PostDatePicker(
              label: "종료일",
              selectedDate: _endDate,
              onDateChanged: (date) => setState(() => _endDate = date),
            ),
            const Divider(),
          ],

          PostFormFooter(
            controller: _textController,
            onSubmit: () async {
              await ref.read(postWriteProvider.notifier).registerPost(_textController.text.trim());
            },
          ),
        ],
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    final postWriteNotifier = ref.read(postWriteProvider.notifier);
    final homeWriteNotifier = ref.read(homeProvider.notifier);
    final session = ref.read(sessionProvider);
    final profileNotifier = ref.read(
      profileProvider(session.user!.userId).notifier,
    );

    return AppBar(
      title: const Text('업로드'),
      actions: [
        TextButton(
          onPressed: () async {
            /// 여기서 그냥 호출만 하면 됨
            await postWriteNotifier.registerPost(_textController.text.trim());
            homeWriteNotifier.init();
            Navigator.popUntil(context, (route) => route.isFirst);
            profileNotifier.init(userId: session.user!.userId);
          },
          child: Text(
            "등록",
            style: TextStyle(
              color: MColor.kText.blue,
              fontSize: MSize.kFont.m,
            ),
          ),
        ),
      ],
    );
  }
}
