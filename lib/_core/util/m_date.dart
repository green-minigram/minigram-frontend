import 'package:timeago/timeago.dart' as timeago;

class MDate {
  /// 초기화 (앱 시작 시 한 번만 호출)
  static void init() {
    timeago.setLocaleMessages('ko', timeago.KoMessages());
  }

  static String timeAgo(String dateTimeStr) {
    try {
      final createdAt = DateTime.parse(dateTimeStr);
      return timeago.format(createdAt, locale: 'ko'); // 한국어 지정
    } catch (e) {
      return dateTimeStr;
    }
  }
}
