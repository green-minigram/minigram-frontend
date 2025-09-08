import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class PostCommentInputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? replyToUser;
  final VoidCallback onCancelReply;
  final VoidCallback onSend;

  const PostCommentInputBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.replyToUser,
    required this.onCancelReply,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (replyToUser != null)
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.m, vertical: MSize.kGap.xs),
            child: Row(
              children: [
                Expanded(
                  child: Text("$replyToUser님에게 답글 남기는 중"),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: MSize.kIcon.xs),
                  onPressed: onCancelReply,
                ),
              ],
            ),
          ),

        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MSize.kGap.m,
              vertical: MSize.kGap.xs,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: MSize.kBorderRadius.l,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                ),
                SizedBox(width: MSize.kGap.xs),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: MSize.kGap.m, vertical: MSize.kGap.xs),
                    decoration: BoxDecoration(
                      color: MColor.kNormal.white,
                      border: Border.all(color: MColor.kLine.main),
                      borderRadius: BorderRadius.circular(MSize.kBorderRadius.xxxl),
                    ),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        hintText: "회원님의 생각을 남겨보세요.",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: MSize.kGap.xs),

                Container(
                  decoration: BoxDecoration(
                    color: MColor.kPrimary.normal,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_upward, color: MColor.kIcon.white),
                    onPressed: onSend,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
