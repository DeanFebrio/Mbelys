import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mbelys/core/router/router.dart';
import 'package:mbelys/presentation/auth/view/forgot_page.dart';
import 'package:mbelys/presentation/auth/view/login_page.dart';
import 'package:mbelys/presentation/auth/view/register_page.dart';
import 'package:mbelys/presentation/common/main_scaffold.dart';
import 'package:mbelys/presentation/error/error_page.dart';
import 'package:mbelys/presentation/home/home_page.dart';
import 'package:mbelys/presentation/kandang/view/add_page.dart';
import 'package:mbelys/presentation/kandang/view/detail_page.dart';
import 'package:mbelys/presentation/profile/view/edit_profil_page.dart';
import 'package:mbelys/presentation/profile/view/feedback_page.dart';
import 'package:mbelys/presentation/profile/view/password_page.dart';
import 'package:mbelys/presentation/profile/view/profile_page.dart';
import 'package:mbelys/presentation/welcome/welcome_page.dart';


class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _shellNavigatorProfil = GlobalKey<NavigatorState>(debugLabel: 'profile');

  static final GoRouter _router = GoRouter(
    initialLocation: RouterPath.welcome,
      navigatorKey: _rootNavigatorKey,
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
                  navigatorKey: _shellNavigatorProfil,
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
      ]
  );

}