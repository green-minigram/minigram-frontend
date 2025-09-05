import 'package:flutter/material.dart';

class MGridItem extends StatelessWidget {
  const MGridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("이미지 클릭됨");
      },
      child: Image.network(
        "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}
