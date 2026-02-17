import 'package:flutter/material.dart';

class GnomesSearchBar extends StatelessWidget {
  const GnomesSearchBar({
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Search by name or profession',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
