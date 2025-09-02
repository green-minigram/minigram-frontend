import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/holder/add/add_page.dart';
import 'package:minigram/ui/pages/holder/home/home_page.dart';
import 'package:minigram/ui/pages/holder/profile/profile_page.dart';
import 'package:minigram/ui/pages/holder/search/search_page.dart';

class MainHolder extends StatefulWidget {
  const MainHolder({Key? key}) : super(key: key);

  @override
  State<MainHolder> createState() => _MainHolderState();
}

class _MainHolderState extends State<MainHolder> {
  int selectedIndex = 0;
  List<int> loadPages = [0]; // 로드된 페이지 인덱스 추적

  // 바텀 메뉴 선택 시 호출되는 함수
  void selectedBottomMenu(int index) {
    // 해당 페이지가 아직 로드되지 않았다면 로드 목록에 추가
    if (!loadPages.contains(index)) {
      loadPages.add(index);
    }
    selectedIndex = index;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          loadPages.contains(0) ? const HomePage() : Container(),
          loadPages.contains(1) ? const SearchPage() : Container(),
          loadPages.contains(2) ? const AddPage() : Container(),
          loadPages.contains(3) ? const ProfilePage() : Container(),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 32,
      currentIndex: selectedIndex,
      onTap: selectedBottomMenu,
      type: BottomNavigationBarType.fixed,
      // 4개 탭이므로 fixed
      selectedItemColor: Colors.black,
      // 선택된 탭 색상
      unselectedItemColor: Colors.grey,
      // 선택되지 않은 탭 색상
      showSelectedLabels: false,
      // 라벨 숨김
      showUnselectedLabels: false,
      // 라벨 숨김
      items: [
        // 홈 탭 (아이콘 변경)
        BottomNavigationBarItem(
          label: '',
          icon: Icon(selectedIndex == 0 ? Icons.home : Icons.home_outlined),
        ),

        // 검색 탭 (아이콘 변경)
        BottomNavigationBarItem(
          label: '',
          icon: Icon(selectedIndex == 1 ? Icons.search : Icons.search_outlined),
        ),

        // 추가 탭 (아이콘 변경)
        BottomNavigationBarItem(
          label: '',
          icon: Icon(selectedIndex == 2 ? Icons.add_circle : Icons.add_circle_outline),
        ),

        // 프로필 탭 (아이콘 변경 + 빨간 점)
        BottomNavigationBarItem(
          label: '',
          icon: Badge(
            smallSize: 8,
            backgroundColor: Colors.red,
            child: Icon(selectedIndex == 3 ? Icons.person : Icons.person_outline),
          ),
        ),
      ],
    );
  }
}
