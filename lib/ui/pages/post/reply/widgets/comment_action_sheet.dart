import 'package:flutter/material.dart';

class CommentActionSheet extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onReply;
  final VoidCallback onDelete;

  const CommentActionSheet({
    super.key,
    required this.onLike,
    required this.onReply,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        // ✅ 추가
        color: Colors.transparent, // 배경은 투명
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("좋아요"),
                trailing: const Icon(Icons.favorite_border),
                onTap: () {
                  onLike();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("답글 달기"),
                trailing: const Icon(Icons.reply),
                onTap: () {
                  onReply();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("삭제", style: TextStyle(color: Colors.red)),
                trailing: const Icon(Icons.delete, color: Colors.red),
                onTap: () {
                  onDelete();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                title: const Center(child: Text("취소")),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
