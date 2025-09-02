import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  PostHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 프로필 이미지 자리
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              "https://i.namu.wiki/i/lbs5tIVXbGEvdR_3Co1azYeKBzKPNbo6GnxiHzndu1dCfSk7rob-Gs2wJZFmC4Oy7O_vq5hmzKzRd3i6WMl9_ul6pRENX1wAUU14fv1G_XFDwx8j1gY2gzugVVYZME2U2oJDqFoqREz3vuM1gcYaAQ.webp", // 프로필 이미지 URL
            ),
          ),
          SizedBox(width: 10),

          // 아이디 + 이름 자리
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "아이디 자리",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  "이름자리",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // TODO 재원님이 만들면 팔로우 버튼 끼우기
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            child: Text("팔로우"),
          ),

          // 더보기 버튼
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
