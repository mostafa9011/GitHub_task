import 'package:flutter/material.dart';
import 'package:github_task/features/auth/domain/entities/github_user_entity.dart';
import 'package:github_task/features/home/presentation/screens/repository_details_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../../features/auth/presentation/screens/login_screen.dart';
import '../../../features/home/presentation/screens/home_screen.dart';
import 'page_name.dart';

class RouteManager {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext currentContext = navigatorKey.currentState!.context;

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PageName.loginScreen:
        return _getPageTransition(
          const LoginScreen(),
          settings: routeSettings,
        );

      case PageName.homeScreen:
        final user = routeSettings.arguments as GithubUserEntity;

        return _getPageTransition(
          HomeScreen(user: user),
          settings: routeSettings,
        );

      case PageName.repositoryDetailsScreen:
        return _getPageTransition(
          const RepositoryDetailsScreen(),
          settings: routeSettings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }

  // ignore: unused_element
  static PageTransition<dynamic> _getPageTransition(
    Widget screen, {
    RouteSettings? settings,
  }) {
    return PageTransition(
      child: screen,
      type: PageTransitionType.fade,
      curve: Curves.easeOut,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 500),
      settings: settings,
    );
  }
}
