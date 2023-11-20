import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/search/search_fragment.dart';
import 'package:fast_app_base/screen/main/tab/todo/todo_fragment.dart';
import 'package:flutter/material.dart';

enum TabItem {
  todo(Icons.event_note_outlined, 'Todo', TodoFragment()),
  search(Icons.search, 'Search', SearchFragment());

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage,
      {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated
              ? context.appColors.iconButton
              : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
