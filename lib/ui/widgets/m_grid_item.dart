import 'package:flutter/material.dart';

class MGridItem extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const MGridItem({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
