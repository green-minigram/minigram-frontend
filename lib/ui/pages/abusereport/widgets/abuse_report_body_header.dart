import 'package:flutter/material.dart';
import 'package:minigram/_core/enums/filter_type.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/abusereport/widgets/report_list_header.dart';
import 'package:minigram/ui/pages/abusereport/widgets/sort_button.dart';

class AbuseReportBodyHeader extends StatelessWidget {
  const AbuseReportBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(delegate: FilterDelegate(), pinned: true);
  }
}

class FilterDelegate extends SliverPersistentHeaderDelegate {
  FilterType? _selectedFilter = FilterType.all;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: MColor.kBackGround.normal,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilterRadioOption(selectedFilter: _selectedFilter, title: '전체', value: FilterType.all),
                FilterRadioOption(selectedFilter: _selectedFilter, title: '대기중', value: FilterType.pending),
                FilterRadioOption(selectedFilter: _selectedFilter, title: '수락됨', value: FilterType.accepted),
                FilterRadioOption(selectedFilter: _selectedFilter, title: '거절됨', value: FilterType.rejected),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SortButton(),
            ],
          ),
          ReportListHeader(),
        ],
      ),
    );
  }

  @override
  double get minExtent => 135.0;

  @override
  double get maxExtent => 135.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class FilterRadioOption extends StatelessWidget {
  const FilterRadioOption({
    super.key,
    required FilterType? selectedFilter,
    required this.title,
    required this.value,
  }) : _selectedFilter = selectedFilter;

  final FilterType? _selectedFilter;
  final String title;
  final FilterType value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<FilterType>(
          value: value,
          groupValue: _selectedFilter,
          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          onChanged: (FilterType? newValue) {},
        ),
        Text(
          title,
          style: TextStyle(fontSize: MSize.kFont.normal),
        ),
      ],
    );
  }
}
