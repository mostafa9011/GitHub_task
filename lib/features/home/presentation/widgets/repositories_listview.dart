import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:github_task/core/config/routes/page_name.dart';
import 'package:github_task/core/extensions/context_extension.dart';
import 'package:github_task/core/utils/widgets/circular_image.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

class RepositoriesListview extends StatelessWidget {
  final List<RepositoryEntity> repositories;

  const RepositoriesListview({super.key, required this.repositories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        return Bounceable(
          onTap: () {
            Navigator.pushNamed(
              context,
              PageName.repositoryDetailsScreen,
              arguments: repositories[index],
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
              title: Text(repositories[index].name),
              subtitle: Text(
                repositories[index].description ?? 'No description available',
              ),
              trailing: CircularImage(
                radius: 16,
                image: repositories[index].owner.avatarUrl,
              ),
            ),
          ),
        );
      },
    );
  }
}
