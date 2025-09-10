import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class ReportCompleteBody extends StatelessWidget {
  const ReportCompleteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // gradient 테두리 원 + 체크
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFD700), // 노랑
                  Color(0xFFFF00FF), // 핑크
                  Color(0xFF8000FF), // 보라
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(2), // 테두리 두께
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 36,
                  color: Colors.black87,
                  weight: 1.5, // 얇은 느낌
                ),
              ),
            ),
          ),

          SizedBox(height: 24),

          // 제목 텍스트
          Text(
            "소중한 의견 감사합니다",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 8),

          // 설명 텍스트
          Text(
            "이 신고를 토대로 앞으로 이 유형의 컨텐츠를 더 적게 표시합니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),

          SizedBox(height: 40),

          // 완료 버튼 (MButton 사용)
          Container(
            child: MButton(
              text: "완료",
              onPressed: () {
                Navigator.pop(context); // 또는 홈으로 이동
              },
              backgroundColor: MColor.kButton.primary,
              textColor: MColor.kNormal.white,
            ),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
