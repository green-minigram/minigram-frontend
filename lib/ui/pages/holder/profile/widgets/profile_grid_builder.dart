import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';

class ProfileGridBuilder extends StatelessWidget {
  const ProfileGridBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MSize.kRatio.aspect34,
        crossAxisSpacing: MSize.kGap.xxxs,
        mainAxisSpacing: MSize.kGap.xxxs,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        if (index == 8) {
          return _AddBox();
        } else {
          return MGridItem();
        }
      },
    );
  }

  Material _AddBox() {
    return Material(
      color: MColor.kBackGround.gray,
      child: InkWell(
        onTap: () {
          print("추가하기 클릭됨");
        },
        child: const Center(
          // 아이콘을 중앙에 배치
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
