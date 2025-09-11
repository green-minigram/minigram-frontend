import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/story/write/widget/story_preview.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_show_alert_dialog.dart';

class StoryDetailBody extends StatefulWidget {
  bool isOwner;

  StoryDetailBody({
    super.key,
    this.isOwner = true,
  });

  @override
  State<StoryDetailBody> createState() => _StoryDetailBodyState();
}

class _StoryDetailBodyState extends State<StoryDetailBody> {
  final List<String> videoUrls = [
    "https://www.pexels.com/ko-kr/download/video/32332683/",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://www.pexels.com/ko-kr/download/video/32332683/",
  ];

  // 배경 영상
  // StoryPreview(videoPath: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"),

  int currentIndex = 0;

  void _goToNextStory() {
    if (currentIndex < videoUrls.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      // 마지막 스토리면 닫기
      Navigator.pop(context);
    }
  }

  void _goToPreviousStory() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    } else {
      // 첫 번째 스토리에서 왼쪽 클릭 시 닫기
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          // 배경 영상 (GestureDetector로 감싸기)
          GestureDetector(
            onTapUp: (details) {
              final screenWidth = MediaQuery.of(context).size.width;
              if (details.localPosition.dx < screenWidth / 2) {
                _goToPreviousStory();
              } else {
                _goToNextStory();
              }
            },
            child: StoryPreview(
              videoPath: videoUrls[currentIndex],
            ),
          ),

          // 오버레이 UI
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 인디케이터 (스토리 진행바 위치)
                Row(
                  children: List.generate(
                    videoUrls.length.clamp(0, 5), // 최대 5개
                    (index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: MSize.kGap.xxxxs),
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MSize.kBorderRadius.xxs),
                            color: index == currentIndex
                                ? MColor.kNormal.white
                                : MColor.kNormal.white.withValues(alpha: 0.3),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: MSize.kGap.s),

                // 프로필 + 아이디 + 시간 + 버튼들
                Row(
                  children: [
                    // 프로필 아바타
                    CircleAvatar(
                      radius: MSize.kBorderRadius.l,
                      backgroundImage: NetworkImage(
                        "https://picsum.photos/200/200",
                      ),
                    ),
                    SizedBox(width: MSize.kGap.xs),

                    // 아이디 + 시간
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "jo_messi_",
                          style: TextStyle(
                            color: MColor.kText.white,
                            fontSize: MSize.kFont.m,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "17시간 전",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: MSize.kFont.s,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),

                    // 팔로우 버튼 (outline 사용)
                    MButton.outline(
                      text: "팔로우",
                      onPressed: () => print("팔로우 클릭"),
                      borderSide: BorderSide(color: MColor.kIcon.white),
                      textColor: MColor.kText.white,
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.m, vertical: MSize.kGap.xs),
                      textSize: MSize.kFont.s,
                      borderRadius: 9,
                    ),
                    SizedBox(width: MSize.kGap.xs),

                    // 좋아요 버튼
                    IconButton(
                      onPressed: () => print("좋아요 클릭"),
                      icon: Icon(Icons.favorite_border, color: MColor.kIcon.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: CircleBorder(),
                        fixedSize: Size(MSize.kIcon.xxl, MSize.kIcon.xxl),
                      ),
                    ),
                    SizedBox(width: MSize.kGap.xs),

                    // 메뉴 버튼
                    IconButton(
                      onPressed: () {
                        MBottomSheet.show(
                          context,
                          items: widget.isOwner
                              ? [
                                  MSheetItem(
                                    text: "삭제",
                                    icon: Icons.delete_outline,
                                    color: MColor.kIcon.red,
                                    onTap: () {
                                      Navigator.pop(context); // 먼저 BottomSheet 닫기
                                      MShowAlertDialog.show(
                                        context,
                                        title: "스토리를 삭제하시겠어요?",
                                        content: "삭제 선택 시 스토리가 영구적으로 삭제됩니다.",
                                        failText: "취소",
                                        successText: "삭제",
                                        onFail: () {
                                          print("삭제 취소됨");
                                        },
                                        onSuccess: () {
                                          print("삭제 실행됨");
                                          // 실제 삭제 로직 호출
                                        },
                                      );
                                    },
                                  ),
                                  MSheetItem(
                                    text: "취소",
                                    icon: Icons.close,
                                    color: MColor.kIcon.normal,
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("신고 클릭됨");
                                    },
                                  ),
                                ]
                              : [
                                  MSheetItem(
                                    text: "신고",
                                    icon: Icons.flag_outlined,
                                    color: MColor.kIcon.red,
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("신고 클릭됨");
                                    },
                                  ),
                                  MSheetItem(
                                    text: "취소",
                                    icon: Icons.close,
                                    color: MColor.kIcon.normal,
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("신고 클릭됨");
                                    },
                                  ),
                                ],
                        );
                      },
                      icon: Icon(Icons.more_horiz, color: MColor.kIcon.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: CircleBorder(),
                        fixedSize: Size(MSize.kIcon.xxl, MSize.kIcon.xxl),
                      ),
                    ),
                    SizedBox(width: MSize.kGap.xs),

                    // 닫기 버튼
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: MColor.kIcon.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: CircleBorder(),
                        fixedSize: Size(MSize.kIcon.xxl, MSize.kIcon.xxl),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
