import 'package:github_task/core/helpers/hive_helper.dart';
import 'package:github_task/features/home/data/models/repository_model.dart';
import 'package:github_task/features/home/domain/entities/repository_entitry.dart';

/// Abstract class for local data source operations
abstract class HomeLocalDataSource {
  /// Save repositories to local storage
  Future<void> saveRepositories(List<RepositoryEntity> repositories);

  /// Get repositories from local storage
  Future<List<RepositoryEntity>> getRepositories();

  /// Save sorting preference
  Future<void> saveSortingPreference(String sortType);

  /// Get sorting preference
  Future<String?> getSortingPreference();

  /// Clear all cached data
  Future<void> clearCache();
}

/// Implementation of local data source using Hive
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String sortingPreferenceKey = 'sorting_preference';

  @override
  Future<void> saveRepositories(List<RepositoryEntity> repositories) async {
    try {
      final box = HiveHelper.getRepositoriesBox();

      // Clear existing data
      await box.clear();

      // Save new data
      for (var i = 0; i < repositories.length; i++) {
        final repo = repositories[i];
        // Convert entity to model if needed
        if (repo is RepositoryModel) {
          await box.put(i, repo);
        } else {
          // Create a RepositoryModel from entity
          final model = RepositoryModel(
            hiveId: repo.id,
            hiveName: repo.name,
            hiveFullName: repo.fullName,
            hiveHtmlUrl: repo.htmlUrl,
            hiveDescription: repo.description,
            hiveDefaultBranch: repo.defaultBranch,
            hiveStargazersCount: repo.stargazersCount,
            hiveForksCount: repo.forksCount,
            hiveOpenIssuesCount: repo.openIssuesCount,
            hiveLanguage: repo.language,
            hiveOwner: OwnerModel(
              hiveId: repo.owner.id,
              hiveUsername: repo.owner.username,
              hiveAvatarUrl: repo.owner.avatarUrl,
              hiveHtmlUrl: repo.owner.htmlUrl,
            ),
            hiveUpdatedAt: repo.updatedAt,
          );
          await box.put(i, model);
        }
      }
    } catch (e) {
      throw Exception('Failed to save repositories to local storage: $e');
    }
  }

  @override
  Future<List<RepositoryEntity>> getRepositories() async {
    try {
      final box = HiveHelper.getRepositoriesBox();
      return box.values.toList();
    } catch (e) {
      throw Exception('Failed to get repositories from local storage: $e');
    }
  }

  @override
  Future<void> saveSortingPreference(String sortType) async {
    try {
      final box = HiveHelper.getSettingsBox();
      await box.put(sortingPreferenceKey, sortType);
    } catch (e) {
      throw Exception('Failed to save sorting preference: $e');
    }
  }

  @override
  Future<String?> getSortingPreference() async {
    try {
      final box = HiveHelper.getSettingsBox();
      return box.get(sortingPreferenceKey);
    } catch (e) {
      throw Exception('Failed to get sorting preference: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final repoBox = HiveHelper.getRepositoriesBox();
      final settingsBox = HiveHelper.getSettingsBox();

      await repoBox.clear();
      await settingsBox.clear();
    } catch (e) {
      throw Exception('Failed to clear cache: $e');
    }
  }
}
