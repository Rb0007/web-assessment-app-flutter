import 'package:flutter/material.dart';
import 'package:flutter_web_iframe_dashboard/pages/dashboard_page.dart';
import 'package:flutter_web_iframe_dashboard/pages/iframe_page.dart';
import 'package:flutter_web_iframe_dashboard/pages/static_page.dart';
import 'package:flutter_web_iframe_dashboard/providers/app_state_provider.dart';
import 'package:flutter_web_iframe_dashboard/widgets/navigation/bottom_nav.dart';
import 'package:flutter_web_iframe_dashboard/widgets/navigation/sidebar_nav.dart';
import 'package:flutter_web_iframe_dashboard/widgets/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../widgets/navigation/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildCurrentPage(AppPage currentPage) {
    switch (currentPage) {
      case AppPage.iframe:
        return const IframePage();
      case AppPage.dashboard:
        return const DashboardPage();
      case AppPage.static:
        return const StaticPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    final currentPage = appState.currentPage;

    return ResponsiveLayout(
      desktop: Row(
        children: [
          const SidebarNav(),
          Expanded(child: _buildCurrentPage(currentPage)),
        ],
      ),
      tablet: Scaffold(
        appBar: AppBar(title: const Text('Flutter Web Dashboard Tablet')),
        drawer: const DrawerNav(),
        body: _buildCurrentPage(currentPage),
      ),
      mobile: Scaffold(
        appBar: AppBar(title: const Text('Flutter Web Dashboard Mobile')),
        body: _buildCurrentPage(currentPage),
        bottomNavigationBar: const BottomNav(),
      ),
    );
  }
}
