import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/utils/global_variable.dart';
import 'package:social_media/utils/palette.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: homeScreenItems,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Palette.black,
          activeColor: Palette.white,
          // inactiveColor: Palette.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: (_page == 0)
                  ? const Icon(
                      FluentIcons.home_12_filled,
                    )
                  : const Icon(
                      FluentIcons.home_12_regular,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: (_page == 1)
                  ? const Icon(
                      Icons.explore,
                    )
                  : const Icon(
                      Icons.explore_outlined,
                    ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: (_page == 2)
                  ? const Icon(
                      Icons.person,
                    )
                  : const Icon(
                      Icons.person_outline,
                    ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: (_page == 3)
                  ? const Icon(
                      Icons.notifications,
                    )
                  : const Icon(
                      Icons.notifications_outlined,
                    ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: (_page == 4)
                  ? const Icon(
                      Icons.menu_outlined,
                    )
                  : const Icon(
                      Icons.menu,
                    ),
              label: 'Menu',
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
