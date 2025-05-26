import 'package:flutter/material.dart';
import 'package:flutter_web_iframe_dashboard/app/theme.dart';

class StaticPage extends StatelessWidget {
  const StaticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.network(
            'https://t3.ftcdn.net/jpg/06/01/17/18/360_F_601171827_GwbDHEuhisbGFXRfIpXFhtf7wAvsbLut.jpg',
          ),
          SizedBox(height: 15),
          Text(
            'Static content page with image',
            textAlign: TextAlign.center,
            style: appTheme.primaryTextTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
