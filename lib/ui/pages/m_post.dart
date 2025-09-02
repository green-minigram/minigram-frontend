import 'package:flutter/material.dart';

// 홈 화면
class Post extends StatelessWidget {
  Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _PostHeader(),
          _PostImage(),
          _PostFooter(),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  _PostHeader({
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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

class _PostImage extends StatelessWidget {
  _PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    int currentPage = 0;

    final List<String> imageUrls = [
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: PageView.builder(
                controller: pageController,
                itemCount: imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 8),

            // 넘기는거 표시하는 곳
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageUrls.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PostFooter extends StatefulWidget {
  _PostFooter({super.key});

  @override
  State<_PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<_PostFooter> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    String content =
        "실연 당한 남성에게 “하늘 날 수 있다” 조언 긴 텍스트 예시입니다. "
        "여기서 내용이 길어지면 더보기 버튼을 눌러야 전체가 보이게 됩니다.";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 좋아요 & 댓글
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 20),
              SizedBox(width: 4),
              Text("3.2만"), // 좋아요 수
              SizedBox(width: 16),
              Icon(Icons.mode_comment_outlined, size: 20),
              SizedBox(width: 4),
              Text("301"), // 댓글 수
            ],
          ),
          SizedBox(height: 6),

          // 글 내용 + 좋아요 + 댓글 + 날짜
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 아이디
              Text(
                "아이디입니다",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),

              // 본문 자리
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 본문
                  Expanded(
                    child: Text(
                      _expanded ? content : (content.length > 30 ? content.substring(0, 30) + "..." : content),
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),

                  // 더보기 버튼 길이 제한 일단 30자로 더 짧으면 안보이게
                  if (!_expanded && content.length > 30)
                    GestureDetector(
                      onTap: () => setState(() => _expanded = true),
                      child: const Text(
                        " 더 보기",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6),

          // 날짜
          Text(
            "8월 20일",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
