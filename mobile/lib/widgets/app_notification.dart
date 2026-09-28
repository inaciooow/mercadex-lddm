import 'dart:async';

import 'package:flutter/material.dart';

void showAppNotification(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.removeCurrentMaterialBanner();
  final controller = messenger.showMaterialBanner(
    MaterialBanner(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: messenger.hideCurrentMaterialBanner,
          child: const Text('Fechar'),
        ),
      ],
    ),
  );
  final timer = Timer(const Duration(seconds: 3), () {
    if (messenger.mounted) controller.close();
  });
  controller.closed.then((_) => timer.cancel());
}
