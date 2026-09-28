import 'package:flutter/material.dart';
import 'package:mercadex/core/config/app_config.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (AppConfig.useMockData)
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'DEBUG',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    );
  }
}
