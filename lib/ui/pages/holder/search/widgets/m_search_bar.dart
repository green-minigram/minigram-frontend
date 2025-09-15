import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/search/search_fm.dart';

class MSearchBar extends ConsumerStatefulWidget {
  const MSearchBar({
    super.key,
  });

  @override
  ConsumerState<MSearchBar> createState() => _MSearchBarState();
}

class _MSearchBarState extends ConsumerState<MSearchBar> {
  @override
  void initState() {
    super.initState();
    final SearchFM fm = ref.read(searchFormProvider.notifier);
    fm.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    final SearchFM fm = ref.read(searchFormProvider.notifier);
    fm.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    final SearchFM fm = ref.read(searchFormProvider.notifier);
    fm.searchBarFocused(fm.focusNode.hasFocus);
  }

  void _onSubmitted(String value) {
    final SearchFM fm = ref.read(searchFormProvider.notifier);
    fm.submitSearch(value: value);
  }

  void _onTap() {
    final SearchFM fm = ref.read(searchFormProvider.notifier);
    fm.requestFocus();
  }

  void _onCancel() {
    final SearchFM fm = ref.read(searchFormProvider.notifier);
    fm.clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    SearchFM fm = ref.read(searchFormProvider.notifier);
    final searchFormModel = ref.watch(searchFormProvider);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MSize.kGap.l,
            left: MSize.kGap.l,
            right: MSize.kGap.l,
            bottom: MSize.kGap.xxxxs,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: fm.textEditingController,
                  onChanged: fm.keword,
                  focusNode: fm.focusNode,
                  onSubmitted: _onSubmitted,
                  onTap: _onTap,
                  style: TextStyle(
                    fontSize: MSize.kFont.l,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        MSize.kBorderRadius.m,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: MColor.kLine.subtle,
                    hintText: '검색',
                    hintStyle: TextStyle(
                      fontSize: MSize.kFont.l,
                      fontWeight: FontWeight.bold,
                      color: MColor.kText.secondary,
                    ),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              if (searchFormModel.isSearchMode)
                InkWell(
                  onTap: _onCancel,
                  child: Container(
                    padding: EdgeInsets.only(left: MSize.kGap.m),
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      "취소",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MSize.kFont.m,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
