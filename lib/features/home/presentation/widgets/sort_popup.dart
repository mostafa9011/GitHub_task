import 'package:flutter/material.dart';

class SortPopup extends StatelessWidget {
  const SortPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: (value) {},
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "name",
          child: Text("Sort by Name"),
        ),
        const PopupMenuItem(
          value: "stars",
          child: Text("Sort by Stars"),
        ),
        const PopupMenuItem(
          value: "date",
          child: Text("Sort by Last Updated"),
        ),
      ],
    );
  }
}
