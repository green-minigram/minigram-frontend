import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/write/post_write_page.dart';
import 'package:minigram/ui/pages/story/write/story_write_page.dart';

class AddBody extends StatelessWidget {
  const AddBody({super.key});

  Widget _buildOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MSize.kBorderRadius.l),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: MSize.kGap.huge),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(MSize.kBorderRadius.l),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: MSize.kIcon.xl, color: color),
            SizedBox(height: MSize.kGap.s),
            Text(
              label,
              style: TextStyle(
                fontSize: MSize.kFont.l,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    Future<void> _pickImages() async {
      try {
        final List<XFile> images = await _picker.pickMultiImage(
          imageQuality: 85,
          limit: 10,
        );
        if (images.isNotEmpty) {
          final paths = images.map((img) => img.path).toList();

          for (var img in images) {
            print("선택한 이미지 경로: ${img.path}");
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostWritePage(imagePaths: paths),
            ),
          );
        } else {
          print("이미지 선택 취소됨");
        }
      } catch (e) {
        print("이미지 선택 중 오류: $e");
      }
    }

    Future<void> _pickVideo(BuildContext context) async {
      try {
        final XFile? video = await _picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(seconds: 60), // 최대 60초
        );

        if (video != null) {
          print("선택한 영상 경로: ${video.path}");
          // StoryWritePage로 이동하면서 videoPath 전달
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StoryWritePage(videoPath: video.path),
            ),
          );
        } else {
          print("영상 선택 취소됨");
        }
      } catch (e) {
        print("영상 선택 중 오류: $e");
      }
    }

    return Padding(
      padding: EdgeInsets.all(MSize.kGap.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildOption(
            icon: Icons.photo_library,
            label: "게시글 등록하기",
            color: MColor.kPrimary.normal,
            onTap: () async {
              print("게시글 등록 선택");
              await _pickImages();
            },
          ),
          SizedBox(height: MSize.kGap.huge),
          _buildOption(
            icon: Icons.play_circle_fill,
            label: "스토리 등록하기",
            color: Colors.blue,
            onTap: () async {
              print("스토리 등록 선택");
              await _pickVideo(context);
            },
          ),
        ],
      ),
    );
  }
}
