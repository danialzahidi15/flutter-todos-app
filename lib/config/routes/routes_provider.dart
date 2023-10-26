import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todos_app/config/routes/routes.dart';
import 'package:go_router/go_router.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteLocation.home,
    navigatorKey: navigationKey,
    routes: appRoutes,
  );
});
