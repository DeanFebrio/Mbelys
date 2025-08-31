import 'package:flutter/material.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/core/router/app_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:mbelys/core/services/service_locator.dart';
import 'package:mbelys/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:mbelys/features/user/presentation/viewmodel/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>.value(value: sl<AuthViewModel>()),

        ChangeNotifierProxyProvider<AuthViewModel, ProfileViewModel>(
            create: (_) => sl<ProfileViewModel>(),
            update: (context, authViewModel, previousProfileViewModel) {
              previousProfileViewModel?.dispose();
              return sl<ProfileViewModel>();
            }
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColors.color10,
            selectionHandleColor: AppColors.color10,
            selectionColor: AppColors.color12.withValues(alpha: 0.5)
          )
        ),
        debugShowCheckedModeBanner: false,
        title: 'Mbelys Application',
        routerConfig: AppRouter.router,
      ),
    );
  }
}