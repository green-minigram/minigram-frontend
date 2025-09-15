import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/main.dart';

/// 1. 창고 관리자
final recentSearchProvider =
    NotifierProvider<RecentSearchGVM, RecentSearchModel>(() {
      return RecentSearchGVM();
    });

/// 2. 창고
class RecentSearchGVM extends Notifier<RecentSearchModel> {
  final mContext = navigatorKey.currentContext!;

  @override
  RecentSearchModel build() {
    // recentSearchList를 null이 아닌 빈 배열로 초기화
    return RecentSearchModel();
  }

  void save(String value) {
    // 값을 받아 최근 검색어 리스트에 저장하는 코드
    if (value.trim().isEmpty) return;

    // 기존 리스트를 가져옴 (이제 무조건 빈 배열로 시작하므로 null 체크 불필요)
    List<String> list = List.from(state.recentSearchList);

    // 이미 존재하는 값이면 삭제(중복 방지)
    list.remove(value);

    // 맨 앞에 추가
    list.insert(0, value);

    // 최대 10개까지만 저장
    if (list.length > 10) {
      list = list.sublist(0, 10);
    }

    // 상태 갱신
    state = RecentSearchModel(recentSearchList: List.from(list));

    Logger().d("최근 검색어 저장됨: $value, 전체: ${state.recentSearchList}");
  }

  /// 최근 검색어 삭제 함수
  void remove(String value) {
    List<String> list = List.from(state.recentSearchList);
    if (list.contains(value)) {
      list.remove(value);
      state = RecentSearchModel(recentSearchList: List.from(list));
      Logger().d("최근 검색어 삭제됨: $value, 전체: ${state.recentSearchList}");
    }
  }

  /// 전체 삭제 함수도 추가 (옵션)
  void clearAll() {
    state = RecentSearchModel(recentSearchList: []);
    Logger().d("최근 검색어 전체 삭제됨");
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class RecentSearchModel {
  List<String> recentSearchList;

  RecentSearchModel({
    List<String>? recentSearchList,
  }) : recentSearchList = recentSearchList ?? [];
}
