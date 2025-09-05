// 사이즈 상수 정의
class MSize {
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

  /// 화면 비율
  static const kRatio = _Ratios();

  /// 보더 곡률
  static const kBorderRadius = _BorderRadius();
}

/// Gap constants
class _Gaps {
  const _Gaps();

  /// 2.0
  final double xxxxs = 2.0;

  /// 3.0
  final double xxxs = 3.0;

  /// 4.0
  final double xxs = 4.0;

  /// 8.0
  final double xs = 8.0;

  /// 10.0
  final double s = 10.0;

  /// 12.0
  final double m = 12.0;

  /// 16.0
  final double l = 16.0;

  /// 20.0
  final double xl = 20.0;

  /// 24.0
  final double xxl = 24.0;

  /// 32.0
  final double huge = 32.0;
  final double doubleHuge = 64.0;
}

/// Icon sizes
class _Icons {
  const _Icons();

  /// 16.0
  final double xxs = 16.0;

  /// 16.0
  final double xs = 18.0;

  /// 20.0
  final double s = 20.0;

  /// 24.0
  final double m = 24.0;

  /// 30.0
  final double l = 30.0;

  /// 32.0
  final double xl = 32.0;
}

/// Story sizes
class _Stories {
  const _Stories();

  /// 게시글 상단 프로필 (50.0)
  final double s = 50.0;

  /// 메인 스토리 프로필 (75.0)
  final double m = 75.0;

  /// 내 정보 페이지 프로필 (110.0)
  final double l = 110.0;
}

/// Font sizes
class _Fonts {
  const _Fonts();

  /// 8.0
  final double xxs = 8.0;

  /// 10.0
  final double tiny = 10.0;

  /// 11.0
  final double xs = 11.0;

  /// 12.0
  final double s = 12.0;

  /// 14.0 (기본 본문)
  final double normal = 14.0;

  /// 16.0
  final double m = 16.0;

  /// 18.0
  final double l = 18.0;

  /// 20.0
  final double xl = 20.0;

  /// 24.0
  final double xxl = 24.0;

  /// 35.0 (특대)
  final double xxxl = 35.0;

  /// 64.0 (초대형)
  final double huge = 64.0;
}

/// Line widths
class _Lines {
  const _Lines();

  /// 0.5 (iOS 헤어라인, 리스트 구분선)
  final double hair = 0.5;

  /// 1.0 (기본 구분선)
  final double normal = 1.0;

  /// 2.0 (강조 라인)
  final double thick = 2.0;

  /// 16.0
  final double width16 = 16.0;
}

/// Ratio widths
class _Ratios {
  const _Ratios();

  /// 3:4 (게시글 비율)
  final double aspect34 = 3 / 4;
}

/// BorderRadius
class _BorderRadius {
  const _BorderRadius();

  /// 8.0
  final double xxs = 3.0;

  /// 8.0
  final double xs = 8.0;

  /// 9.0
  final double s = 9.0;

  /// 16.0
  final double m = 16.0;

  /// 18.0
  final double l = 18.0;

  /// 20.0
  final double xl = 24.0;

  /// 24.0
  final double xxl = 24.0;

  /// 24.0
  final double xxxl = 30.0;
}
