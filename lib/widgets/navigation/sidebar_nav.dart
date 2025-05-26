import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';

class SidebarNav extends StatelessWidget {
  const SidebarNav({super.key});

  final List<_NavItem> _navItems = const [
    _NavItem('Iframe', Icons.web, AppPage.iframe),
    _NavItem('Dashboard', Icons.dashboard, AppPage.dashboard),
    _NavItem('Static', Icons.article, AppPage.static),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final activePage = appState.currentPage;

    return Material(
      color: Colors.blueGrey.shade900,
      child: Container(
        width: 250,
        color: Colors.blueGrey.shade900,
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Flutter Web App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _navItems.map((item) {
                  final selected = activePage == item.page;
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: selected ? Colors.white : Colors.white70,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.white70,
                      ),
                    ),
                    selected: selected,
                    selectedTileColor: Colors.blueGrey.shade700,
                    hoverColor: Colors.blueGrey.shade600,
                    onTap: () {
                      appState.changePage(item.page);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String title;
  final IconData icon;
  final AppPage page;

  const _NavItem(this.title, this.icon, this.page);
}
