import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/gvm/recent_search_gvm.dart';
import 'package:minigram/main.dart';
import 'package:minigram/ui/pages/holder/search/search_vm.dart';

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
  final focusNode = FocusNode();

  @override
  SearchFormModel build() {
    ref.onDispose(() {
      textEditingController.dispose();
      focusNode.dispose();
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

  void requestFocus() {
    if (!focusNode.hasFocus) {
      focusNode.requestFocus();
    }
  }

  void unfocus() {
    focusNode.unfocus();
  }

  // value가 있으면 모델의 최근 검색어와 텍스트 컨트롤러의 text도 value로 설정
  Future<void> submitSearch({String? value}) async {
    String keyword;
    if (value != null && value.isNotEmpty) {
      keyword = value;
      // 모델의 최근 검색어와 텍스트 컨트롤러의 text를 value로 변경
      state = state.copyWith(currentSearchKeyword: value);
      textEditingController.text = value;
    } else {
      keyword = state.currentSearchKeyword;
    }
    if (keyword.isNotEmpty) {
      // 최근 검색어 저장
      ref.read(recentSearchProvider.notifier).save(keyword);

      // 검색 실행 후 검색 모드 해제
      state = state.copyWith(
        isSearchMode: false,
        isSearchBarFocused: false,
        isLoading: true,
      );
      focusNode.unfocus();

      // 실제 검색 API 호출
      await ref.read(searchProvider.notifier).init(keyword: keyword);

      // 로딩 완료
      state = state.copyWith(isLoading: false);
    }
  }

  void clearSearch() {
    state = state.copyWith(
      currentSearchKeyword: '',
      isSearchBarFocused: false,
      isSearchMode: false, // ✅ 검색 모드 해제
    );
    textEditingController.clear();
    focusNode.unfocus();
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
  final bool isLoading; // ✅ 로딩 상태 추가

  SearchFormModel({
    required this.isSearchBarFocused,
    required this.currentSearchKeyword,
    this.isSearchMode = false, // ✅ 기본값 false
    this.isLoading = false, // ✅ 기본값 false
  });

  SearchFormModel copyWith({
    bool? isSearchBarFocused,
    String? currentSearchKeyword,
    bool? isSearchMode,
    bool? isLoading,
  }) {
    return SearchFormModel(
      isSearchBarFocused: isSearchBarFocused ?? this.isSearchBarFocused,
      currentSearchKeyword: currentSearchKeyword ?? this.currentSearchKeyword,
      isSearchMode: isSearchMode ?? this.isSearchMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
