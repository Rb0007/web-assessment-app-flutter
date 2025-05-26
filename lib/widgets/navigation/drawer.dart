import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state_provider.dart';

class DrawerNav extends StatelessWidget {
  const DrawerNav({super.key});

  final List<_NavItem> _navItems = const [
    _NavItem('Iframe', Icons.web, AppPage.iframe),
    _NavItem('Dashboard', Icons.dashboard, AppPage.dashboard),
    _NavItem('Static', Icons.article, AppPage.static),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateProvider>();
    final activePage = appState.currentPage;

    return Drawer(
      child: Container(
        color: Colors.blueGrey.shade900,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey.shade800),
              child: const Center(
                child: Text(
                  'Flutter Web App Drawer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: _navItems.map((item) {
                  final selected = activePage == item.page;
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: selected ? Colors.white : Colors.grey.shade300,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.grey.shade100,
                      ),
                    ),
                    selected: selected,
                    selectedTileColor: selected
                        ? Colors.amber
                        : Colors.blueGrey.shade700,
                    // hoverColor: Colors.blueGrey.shade600,
                    onTap: () {
                      appState.changePage(item.page);
                      Navigator.pop(context); // Close drawer on selection
                    },
                  );
                }).toList(),
              ),
            ),
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
