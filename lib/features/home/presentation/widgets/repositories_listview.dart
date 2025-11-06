import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:github_task/core/config/routes/page_name.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';

class RepositoriesListview extends StatelessWidget {
  const RepositoriesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Bounceable(
          onTap: () {
            Navigator.pushNamed(
              context,
              PageName.repositoryDetailsScreen,
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: context.colorScheme.primary, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text('Repository $index'),
              subtitle: Text('Description of repository $index'),
              trailing: const CircularImage(radius: 16, image: 'image'),
            ),
          ),
        );
      },
    );
  }
}
