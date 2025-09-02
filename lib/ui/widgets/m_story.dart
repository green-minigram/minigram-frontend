import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  final double size;
  final String imageUrl;

  const Story({
    super.key,
    this.size = 70,
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
            Color(0xfffce80a),
            Color(0xfffce80a),
            Color(0xfffc3a0a),
            Color(0xffc80afc),
            Color(0xfffce80a),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
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
