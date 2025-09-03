import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart'; // 사이즈 상수
import 'package:minigram/ui/widgets/story.dart';

class StoryList extends StatelessWidget {
  // final List<Map<String, dynamic>> stories;
  final List<Map<String, dynamic>> dummyStories = List.generate(
    10,
    (index) => {
      'author': {
        'username': 'user$index',
        'profileImageUrl': 'https://picsum.photos/seed/$index/200/200',
      },
    },
  );

  StoryList({
    super.key,
    // required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MSizes.kStory.m + MSizes.kGap.l + MSizes.kFont.s,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: MSizes.kGap.s),
        itemCount: dummyStories.length.clamp(0, 10),
        separatorBuilder: (_, __) => SizedBox(width: MSizes.kGap.m),
        itemBuilder: (context, index) {
          final story = dummyStories[index];
          final username = story['author']['username'];
          final profileUrl = story['author']['profileImageUrl'];

          if (index == 0) {
            // 내 스토리
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print("내 스토리 클릭됨");
                  },
                  child: Stack(
                    children: [
                      Story(
                        size: MSizes.kStory.m,
                        imageUrl: profileUrl,
                        isGradient: false,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: MColor.kPrimary.normal,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: MColor.kNormal.white,
                              width: MSizes.kLine.normal,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: MSizes.kIcon.m,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MSizes.kGap.s),
                Text(
                  "내 스토리",
                  style: TextStyle(fontSize: MSizes.kFont.s),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          }

          // 스토리들
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  print("$username 스토리 클릭됨");
                },
                child: Story(
                  size: MSizes.kStory.m,
                  imageUrl: profileUrl,
                ),
              ),
              SizedBox(height: MSizes.kGap.s),
              Text(
                username,
                style: TextStyle(fontSize: MSizes.kFont.s),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
