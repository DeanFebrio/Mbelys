import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mbelys/core/router/router.dart';
import 'package:mbelys/view/pages/detail/detail_page.dart';
import 'package:mbelys/view/pages/edit_profil/edit_profil_page.dart';
import 'package:mbelys/view/pages/error/error_page.dart';
import 'package:mbelys/view/pages/forgot/forgot_page.dart';
import 'package:mbelys/view/pages/home/home_page.dart';
import 'package:mbelys/view/pages/login/login_page.dart';
import 'package:mbelys/view/pages/password/password_page.dart';
import 'package:mbelys/view/pages/profil/profil_page.dart';
import 'package:mbelys/view/pages/register/register_page.dart';
import 'package:mbelys/view/pages/welcome/welcome_page.dart';


class AppRouter {
  static GoRouter get router => _router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

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
            path: RouterPath.home,
            name: RouterName.home,
            builder: (context, state) => const HomePage()
        ),
        GoRoute(
            path: RouterPath.detail,
            name: RouterName.detail,
            builder: (context, state) => const DetailPage()
        ),
        GoRoute(
            path: RouterPath.profil,
            name: RouterName.profil,
            builder: (context, state) => const ProfilPage()
        ),
        GoRoute(
            path: RouterPath.editProfil,
            name: RouterName.editProfil,
            builder: (context, state) => const EditProfilPage()
        ),
        GoRoute(
            path: RouterPath.password,
            name: RouterName.password,
            builder: (context, state) => const PasswordPage()
        ),
      ]
  );

}