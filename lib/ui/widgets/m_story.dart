import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MStory extends StatelessWidget {
  final double size;
  final String imageUrl;
  final bool isGradient;

  const MStory({
    super.key,
    required this.size,
    this.imageUrl =
        'https://pixabay.com/ko/photos/%EA%B3%A0%EC%96%91%EC%9D%B4-%EC%A3%BC%EB%B0%A9-%EC%95%A0%EC%99%84-%EB%8F%99%EB%AC%BC-%EB%8F%99%EB%AC%BC-9769723/',
    this.isGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isGradient
            ? LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  MColor.kInsta.yellow,
                  MColor.kInsta.orange,
                  MColor.kInsta.red,
                  MColor.kInsta.pink,
                  MColor.kInsta.purple,
                ],
              )
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(MSize.kGap.xxxs),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MColor.kNormal.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(MSize.kGap.xxs),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: size / 2,
            ),
          ),
        ),
      ),
    );
  }
}
