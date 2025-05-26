import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  final List<_NavItem> _navItems = const [
    _NavItem('Iframe', Icons.web, AppPage.iframe),
    _NavItem('Dashboard', Icons.dashboard, AppPage.dashboard),
    _NavItem('Static', Icons.article, AppPage.static),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final activePage = appState.currentPage;

    int currentIndex = _navItems.indexWhere((item) => item.page == activePage);

    return BottomNavigationBar(
      currentIndex: currentIndex >= 0 ? currentIndex : 0,
      items: _navItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.title,
        );
      }).toList(),
      onTap: (index) => appState.changePage(_navItems[index].page),
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}

class _NavItem {
  final String title;
  final IconData icon;
  final AppPage page;

  const _NavItem(this.title, this.icon, this.page);
}
