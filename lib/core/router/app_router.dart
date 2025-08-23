import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mbelys/core/error/error_page.dart';
import 'package:mbelys/core/router/router.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/presentation/pages/forgot_page.dart';
import 'package:mbelys/features/auth/presentation/pages/login_page.dart';
import 'package:mbelys/features/auth/presentation/pages/register_page.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/home/presentation/pages/home_page.dart';
import 'package:mbelys/features/kandang/presentation/view/add_page.dart';
import 'package:mbelys/features/kandang/presentation/view/detail_page.dart';
import 'package:mbelys/features/user/presentation/pages/edit_profile_page.dart';
import 'package:mbelys/features/user/presentation/pages/feedback_page.dart';
import 'package:mbelys/features/user/presentation/pages/password_page.dart';
import 'package:mbelys/features/user/presentation/pages/profile_page.dart';
import 'package:mbelys/features/welcome/welcome_page.dart';
import 'package:mbelys/presentation/common/main_scaffold.dart';
import 'package:mbelys/presentation/common/splash_page.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'profile');

  static final AuthViewModel authViewModel = sl<AuthViewModel>();

  static final GoRouter _router = GoRouter(
    initialLocation: RouterPath.welcome,
      navigatorKey: _rootNavigatorKey,
      refreshListenable: authViewModel,
      errorBuilder: (context, state) => const ErrorPage(),
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            path: RouterPath.welcome,
          name: RouterName.welcome,
          builder: (context, state) => const WelcomePage()
        ),
        GoRoute(
            path: RouterPath.login,
            name: RouterName.login,
            builder: (context, state) => const LoginPage()
        ),
        GoRoute(
            path: RouterPath.forgot,
            name: RouterName.forgot,
            builder: (context, state) => const ForgotPage()
        ),
        GoRoute(
            path: RouterPath.register,
            name: RouterName.register,
            builder: (context, state) => const RegisterPage()
        ),
        GoRoute(
            path: RouterPath.detail,
            name: RouterName.detail,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) => const DetailPage()
        ),
        GoRoute(
            path: RouterPath.editProfile,
            name: RouterName.editProfile,
            builder: (context, state) => const EditProfilePage()
        ),
        GoRoute(
            path: RouterPath.password,
            name: RouterName.password,
            builder: (context, state) => const PasswordPage()
        ),
        GoRoute(
            path: RouterPath.feedback,
            name: RouterName.feedback,
            builder: (context, state) => const FeedbackPage()
        ),
        GoRoute(
            path: RouterPath.add,
            name: RouterName.add,
            builder: (context, state) => const AddPage()
        ),
        GoRoute(
            path: RouterPath.splash,
            name: RouterName.splash,
            builder: (context, state) => const SplashPage()
        ),

        StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state, navigationShell) {
              return MainScaffold(statefulNavigationShell: navigationShell,);
            },
            branches: [
              StatefulShellBranch(
                navigatorKey: _shellNavigatorHome,
                  routes: [
                    GoRoute(
                        path: RouterPath.home,
                        name: RouterName.home,
                        builder: (context, state) => const HomePage(),
                    ),
                  ]
              ),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorProfile,
                  routes: [
                    GoRoute(
                        path: RouterPath.profile,
                        name: RouterName.profile,
                        builder: (context, state) => const ProfilePage()
                    ),
                  ]
              )
            ]
        )
      ],
    redirect: (BuildContext context, GoRouterState state) {
      final status = authViewModel.status;
      final location = state.matchedLocation;

      final publicRoutes = [
        RouterPath.welcome,
        RouterPath.login,
        RouterPath.forgot,
        RouterPath.register,
        RouterPath.splash
      ];

      final isPublic = publicRoutes.contains(location);
      final isLoggedIn = status == AuthStatus.authenticated;

      if (status == AuthStatus.unknown) {
        return location == RouterPath.splash ? null : RouterPath.splash;
      }

      if (status == AuthStatus.unauthenticated) {
        return isPublic ? null : RouterPath.welcome;
      }

      if (!isLoggedIn && !isPublic) {
        return RouterPath.welcome;
      }

      if (isLoggedIn && isPublic) {
        return RouterPath.home;
      }

      return null;
    }
  );
}