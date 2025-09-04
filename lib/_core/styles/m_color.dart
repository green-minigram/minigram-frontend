import 'package:flutter/material.dart';

class MColor {
  /// 메인 색상
  static const kPrimary = _PrimaryColors();

  /// 인스타 로고 색상
  static const kInsta = _InstaColors();

  /// 배경 색상
  static const kBackGround = _BackGrounds();

  /// 선 색상
  static const kLine = _Lines();

  /// 버튼 색상
  static const kButton = _Buttons();

  /// 일반 색상
  static const kNormal = _Normals();

  /// 글자 색상
  static const kText = _Texts();

  /// 입력란 배경 색상
  static const kInputBackGround = _InputBackGrounds();

  /// 페이지 이동 인디케이터 색상
  static const kIndicator = _Indicators();

  /// 페이지 이동 인디케이터 색상
  static const kIcon = _Icons();
}

/// Primary Colors
class _PrimaryColors {
  const _PrimaryColors();

  /// 메인 블루
  final Color normal = const Color(0xFF1877F2);

  /// 진한 블루
  final Color strong = const Color(0xFF145DBF);

  /// 가장 진한 블루
  final Color heavy = const Color(0xFF0D47A1);
}

/// Normal Colors
class _Normals {
  const _Normals();

  /// 흰색
  final Color white = const Color(0xFFFFFFFF);

  /// 검은색
  final Color black = const Color(0xFF000000);

  /// 회색 (light) shade100
  final Color grey100 = const Color(0xFFF5F5F5);

  /// 회색 (중간) shade400
  final Color grey400 = const Color(0xFFBDBDBD);
}

/// Instagram Gradient Colors
class _InstaColors {
  const _InstaColors();

  /// 보라
  final Color purple = const Color(0xFF7137EC);

  /// 보라/핑크
  final Color pink = const Color(0xFFA624E2);

  /// 노랑
  final Color yellow = const Color(0xFFF6C243);

  /// 오렌지
  final Color orange = const Color(0xFFE6563C);

  /// 빨강
  final Color red = const Color(0xFFE64041);
}

/// BackGround Colors
class _BackGrounds {
  const _BackGrounds();

  /// 기본 흰색
  final Color normal = const Color(0xFFFFFFFF);
}

/// Line Colors
class _Lines {
  const _Lines();

  /// 메인 화면 구분선
  final Color main = const Color(0xFFE3E3E3);

  /// 그 외 얇은 구분선
  final Color subtle = const Color(0xFFE9EDF0);

  /// 신고 목록 화면
  final Color warning = const Color(0xFFDBDBDB);
}

/// Button Colors
class _Buttons {
  const _Buttons();

  /// 좋아요
  final Color like = const Color(0xFFFF0009);

  /// 메인 프라이머리 버튼
  final Color primary = const Color(0xFF4A5EF9);

  /// 비활성화 버튼
  final Color disabled = const Color(0xFFEEF2F5);
}

/// Text Colors
class _Texts {
  const _Texts();

  /// 일반 본문
  final Color normal = const Color(0xFF0A0F13);

  /// 큰 제목, 헤드라인
  final Color title = const Color(0xFF0A1317);

  /// 안내/설명 문구 (신고하기 안내 등)
  final Color description = const Color(0xFF5D6C7B);

  /// 날짜/보조 정보
  final Color secondary = const Color(0xFF68717B);

  /// 에러/경고 텍스트
  final Color red = const Color(0xFFFF453A);

  /// 수정/완료 텍스트
  final Color blue = const Color(0xFF3F4FEE);
}

/// Input Colors
class _InputBackGrounds {
  const _InputBackGrounds();

  /// 검색 입력박스 배경
  final Color background = const Color(0xFFF3F5F7);

  /// 로그인 입력박스 배경
  final Color normal = const Color(0xFFFFFFFF);
}

/// Indicator Colors
class _Indicators {
  const _Indicators();

  /// 현재 페이지 (활성화)
  final Color active = const Color(0xFF1877F2);

  /// 다른 페이지 (비활성화)
  final Color inactive = const Color(0xFF9E9E9E);
}

/// Icon Colors
class _Icons {
  const _Icons();

  /// 신고/삭제 등등
  final Color red = const Color(0xFFFF453A);

  /// 기본 아이콘 (검은색)
  final Color normal = const Color(0xFF000000);
}
