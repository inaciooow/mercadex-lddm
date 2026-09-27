import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({super.key, this.hintText = 'Buscar'});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
