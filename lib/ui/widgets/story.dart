import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';

class Story extends StatelessWidget {
  final double size;
  final String imageUrl;

  const Story({
    super.key,
    required this.size,
    this.imageUrl = "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            // hex 컬러
            MColor.kInsta.yellow,
            MColor.kInsta.yellow,
            MColor.kInsta.orange,
            MColor.kInsta.red,
            MColor.kInsta.pink,
            MColor.kInsta.purple,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MColor.kNormal.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(4),
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
