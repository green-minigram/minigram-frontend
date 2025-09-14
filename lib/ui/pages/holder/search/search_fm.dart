import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/main.dart';

/// 1. 창고 관리자
final searchFormProvider =
    AutoDisposeNotifierProvider<SearchFM, SearchFormModel>(
      () {
        return SearchFM();
      },
    );

/// 2. 창고
class SearchFM extends AutoDisposeNotifier<SearchFormModel> {
  final mContext = navigatorKey.currentContext!;
  final textEditingController = TextEditingController();

  @override
  SearchFormModel build() {
    ref.onDispose(() {
      textEditingController.dispose();
      Logger().d("SearchFM 파괴됨");
    });

    return SearchFormModel(
      isSearchBarFocused: false,
      currentSearchKeyword: "",
      isSearchMode: false, // ✅ 초기값
    );
  }

  /// 검색어 상태 변경 메서드
  void keword(String keyword) {
    state = state.copyWith(
      currentSearchKeyword: keyword,
    );
  }

  void searchBarFocused(bool isFocused) {
    state = state.copyWith(
      isSearchBarFocused: isFocused,
      isSearchMode: isFocused
          ? true
          : state.isSearchMode, // ✅ 포커스 시에만 검색 모드 활성화
    );
  }

  // 받을 수도 있고 안 받을 수도 있게 수정
  void submitSearch([String? value]) {
    String keyword;
    if (value != null && value.isNotEmpty) {
      keyword = value;
    } else {
      keyword = state.currentSearchKeyword;
    }
    if (keyword.isNotEmpty) {
      // 검색 실행 후 검색 모드 해제
      state = state.copyWith(isSearchMode: false);
      // 실제 검색 API 호출
    }
  }

  void clearSearch() {
    state = state.copyWith(
      currentSearchKeyword: '',
      isSearchBarFocused: false,
      isSearchMode: false, // ✅ 검색 모드 해제
    );
    textEditingController.clear();
  }

  // ✅ 최근 검색어 선택 시 호출할 메서드 추가
  void selectRecentSearch(String keyword) {
    textEditingController.text = keyword;
    state = state.copyWith(
      currentSearchKeyword: keyword,
      isSearchMode: false, // ✅ 검색 모드 해제하여 결과 화면으로 전환
    );
    // 실제 검색 실행
  }
}

/// 3. 창고 데이터 타입
class SearchFormModel {
  final bool isSearchBarFocused;
  final String currentSearchKeyword;
  final bool isSearchMode; // ✅ 검색 모드 상태 추가

  SearchFormModel({
    required this.isSearchBarFocused,
    required this.currentSearchKeyword,
    this.isSearchMode = false, // ✅ 기본값 false
  });

  SearchFormModel copyWith({
    bool? isSearchBarFocused,
    String? currentSearchKeyword,
    bool? isSearchMode,
  }) {
    return SearchFormModel(
      isSearchBarFocused: isSearchBarFocused ?? this.isSearchBarFocused,
      currentSearchKeyword: currentSearchKeyword ?? this.currentSearchKeyword,
      isSearchMode: isSearchMode ?? this.isSearchMode,
    );
  }
}
