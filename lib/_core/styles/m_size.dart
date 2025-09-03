// 사이즈 상수 정의
class MSizes {
  /// 여백 (gap)
  static const kGap = _Gaps();

  /// 아이콘 크기
  static const kIcon = _Icons();

  /// 스토리 크기
  static const kStory = _Stories();

  /// 폰트 크기
  static const kFont = _Fonts();

  /// 선 굵기
  static const kLine = _Lines();

  /// 보더 곡률
  static const kBorderRadius = _BorderRadius();
}

/// Gap constants
class _Gaps {
  const _Gaps();

  final double xxs = 2.0;
  final double xs = 5.0;
  final double s = 8.0;
  final double m = 10.0;
  final double l = 16.0;
  final double xl = 20.0;
  final double xxl = 24.0;
  final double huge = 32.0;
}

/// Icon sizes
class _Icons {
  const _Icons();

  final double s = 16.0;
  final double m = 24.0;
  final double l = 32.0;
}

/// Story sizes
class _Stories {
  const _Stories();

  /// 게시글 상단 프로필
  final double s = 50.0;

  /// 메인 스토리 프로필
  final double m = 75.0;

  /// 내 정보 페이지 프로필
  final double l = 110.0;
}

/// Font sizes
class _Fonts {
  const _Fonts();

  final double xxs = 8.0;
  final double tiny = 10.0;
  final double xs = 11.0;
  final double s = 12.0;
  final double normal = 14.0;
  final double m = 16.0;
  final double l = 18.0;
  final double xl = 20.0;
  final double xxl = 24.0;
  final double huge = 64.0;
}

/// Line widths
class _Lines {
  const _Lines();

  /// iOS 헤어라인 (리스트 구분선)
  final double hair = 0.5;

  /// 기본 구분선
  final double normal = 1.0;

  /// 강조 라인
  final double thick = 2.0;
}

/// BorderRadius
class _BorderRadius {
  const _BorderRadius();

  /// 8.0
  final double s = 8.0;

  /// 16.0
  final double m = 16.0;

  /// 24.0
  final double l = 24.0;
}
