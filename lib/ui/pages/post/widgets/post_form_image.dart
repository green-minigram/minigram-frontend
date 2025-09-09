import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class PostFormImage extends StatefulWidget {
  final List<String> imagePaths; // 선택된 이미지 경로 리스트

  const PostFormImage({
    super.key,
    // required this.imagePaths,
    this.imagePaths = const [
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
    ],
  });

  @override
  State<PostFormImage> createState() => _PostFormImageState();
}

class _PostFormImageState extends State<PostFormImage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.imagePaths.isEmpty) {
      return Container(
        height: 300,
        color: MColor.kBackGround.normal,
        child: Center(
          child: Text(
            "이미지를 선택해주세요",
            style: TextStyle(color: MColor.kText.secondary),
          ),
        ),
      );
    }

    return Column(
      children: [
        // 이미지 슬라이드
        AspectRatio(
          aspectRatio: MSize.kRatio.aspect34, // 3:4 비율
          child: PageView.builder(
            itemCount: widget.imagePaths.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              final path = widget.imagePaths[index];

              if (path.startsWith('http')) {
                return Image.network(path, fit: BoxFit.cover);
              } else {
                return Image.file(File(path), fit: BoxFit.cover);
              }
            },
          ),
        ),

        SizedBox(height: MSize.kGap.s),

        // 인디케이터 (여러 장일 때 점 표시)
        if (widget.imagePaths.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? MColor.kIndicator.active : MColor.kIndicator.inactive,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
