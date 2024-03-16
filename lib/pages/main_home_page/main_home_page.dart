import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mockspotify/api/api.dart';
import 'package:mockspotify/pages/search_page/search_page.dart';

import '../home_page/home_page.dart';
import '../library_page/library_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  static String get path => '/main-home-page';
  static String get name => 'main_home_page';

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int currentPageIndex = 0;
  final pages = [
    const HomePage(),
    const SearchPage(),
    const SearchPage(),
    const LibraryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(builder: (context) {
        final TabController? tabController = DefaultTabController.of(context);
        API.getAccessToken();
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 18, 16, 16),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            height: 71,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 18, 16, 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navigationItem(
                  onpressed: () {
                    tabController?.animateTo(0);
                    setState(() {
                      currentPageIndex = 0;
                    });
                  },
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home_filled,
                  isSelected: currentPageIndex == 0,
                  name: 'Home',
                ),
                _navigationItem(
                  onpressed: () {
                    tabController?.animateTo(1);

                    setState(() {
                      currentPageIndex = 1;
                    });
                  },
                  icon: Icons.play_arrow_outlined,
                  selectedIcon: Icons.play_arrow,
                  isSelected: currentPageIndex == 1,
                  name: 'Samples',
                ),
                _navigationItem(
                  onpressed: () {
                    tabController?.animateTo(2);

                    setState(() {
                      currentPageIndex = 2;
                    });
                  },
                  icon: Icons.explore_outlined,
                  selectedIcon: Icons.explore,
                  isSelected: currentPageIndex == 2,
                  name: 'Explore',
                ),
                _navigationItem(
                  onpressed: () {
                    tabController?.animateTo(3);

                    setState(() {
                      currentPageIndex = 3;
                    });
                  },
                  icon: Icons.library_music_outlined,
                  selectedIcon: Icons.library_music,
                  isSelected: currentPageIndex == 3,
                  name: 'Your Library',
                ),
              ],
            ),
          ),
          // body: pages[currentPageIndex],
          body: TabBarView(controller: tabController, children: pages),
        );
      }),
    );
  }
}

class _navigationItem extends StatefulWidget {
  const _navigationItem(
      {super.key,
      required this.onpressed,
      required this.icon,
      required this.selectedIcon,
      required this.isSelected,
      required this.name});
  final void Function() onpressed;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final String name;

  @override
  State<_navigationItem> createState() => __navigationItemState();
}

class __navigationItemState extends State<_navigationItem> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.onpressed,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Icon(
            widget.isSelected ? widget.selectedIcon : widget.icon,
            size: 20,
            color: widget.isSelected ? Colors.white : Colors.grey,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            widget.name,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
