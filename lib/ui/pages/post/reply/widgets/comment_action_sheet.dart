import 'dart:ui';

import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String username;
  final String content;

  const CommentCard({
    super.key,
    required this.username,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        _showCommentActionSheet(context, details.globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text("$username: $content"),
      ),
    );
  }

  void _showCommentActionSheet(BuildContext context, Offset position) {
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // 배경 블러 + 딤 처리
            Positioned.fill(
              child: GestureDetector(
                onTap: () => entry.remove(), // 바깥 터치 시 닫기
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),

            // 댓글 카드 + 액션시트
            Positioned(
              left: 16,
              right: 16,
              top: position.dy, // 롱프레스한 y좌표에 맞춰 표시
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 댓글 미리보기 카드
                  Material(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withValues(alpha: 0.2),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("$username: $content"),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 액션시트
                  Material(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildActionItem(
                          icon: Icons.video_collection_outlined,
                          text: "릴스로 답글 달기",
                          onTap: () {
                            print("릴스로 답글 달기");
                            entry.remove();
                          },
                        ),
                        _buildActionItem(
                          icon: Icons.add_circle_outline,
                          text: "스토리에 추가",
                          onTap: () {
                            print("스토리에 추가");
                            entry.remove();
                          },
                        ),
                        _buildActionItem(
                          icon: Icons.report_outlined,
                          text: "신고",
                          color: Colors.red,
                          onTap: () {
                            print("신고");
                            entry.remove();
                          },
                        ),
                        _buildActionItem(
                          icon: Icons.block,
                          text: "차단",
                          color: Colors.red,
                          onTap: () {
                            print("차단");
                            entry.remove();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(entry);
  }

  Widget _buildActionItem({
    required IconData icon,
    required String text,
    Color color = Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }
}
