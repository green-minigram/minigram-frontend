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

    return SearchFormModel(isSearchBarFocused: false, currentSearchKeyword: "");
  }

  void keword(String keyword) {
    print(textEditingController.value.text);
    state = state.copyWith(currentSearchKeyword: keyword);
  }

  void searchBarFocused(bool isFocused) {
    state = state.copyWith(isSearchBarFocused: isFocused);
  }

  // 검색 제출
  void submitSearch() {
    if (state.currentSearchKeyword.isEmpty) {
      // 여기서 실제 검색 API 호출 등을 수행
    }
  }

  // 검색 취소/클리어
  void clearSearch() {
    state = state.copyWith(
      currentSearchKeyword: '',
      isSearchBarFocused: false,
    );
    textEditingController.clear();
  }
}

/// 3. 창고 데이터 타입
class SearchFormModel {
  final bool isSearchBarFocused;
  final String currentSearchKeyword;

  SearchFormModel({
    required this.isSearchBarFocused,
    required this.currentSearchKeyword,
  });

  SearchFormModel copyWith({
    bool? isSearchBarFocused,
    String? currentSearchKeyword,
  }) {
    return SearchFormModel(
      isSearchBarFocused: isSearchBarFocused ?? this.isSearchBarFocused,
      currentSearchKeyword: currentSearchKeyword ?? this.currentSearchKeyword,
    );
  }
}
