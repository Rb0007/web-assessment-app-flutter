import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  const ResponsiveLayout({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 768 && w < 1024;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
