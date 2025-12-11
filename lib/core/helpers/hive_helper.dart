import 'package:github_task/features/home/data/models/repository_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Helper class to initialize and manage Hive database
class HiveHelper {
  static const String repositoriesBox = 'repositories_box';
  static const String settingsBox = 'settings_box';

  /// Initialize Hive with Flutter and register adapters
  static Future<void> init() async {
    // Initialize Hive for Flutter
    await Hive.initFlutter();

    // Register type adapters for our models
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(RepositoryModelAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(OwnerModelAdapter());
    }

    // Open boxes
    await Hive.openBox<RepositoryModel>(repositoriesBox);
    await Hive.openBox(settingsBox);
  }

  /// Get repositories box
  static Box<RepositoryModel> getRepositoriesBox() {
    return Hive.box<RepositoryModel>(repositoriesBox);
  }

  /// Get settings box
  static Box getSettingsBox() {
    return Hive.box(settingsBox);
  }

  /// Close all boxes
  static Future<void> closeBoxes() async {
    await Hive.close();
  }
}
