import 'package:flutter/material.dart';
import 'package:mbelys/core/constant/app_colors.dart';
import 'package:mbelys/core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.color10,
          selectionHandleColor: AppColors.color10
        )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mbelys Application',
      routerConfig: AppRouter.router,
    );
  }
}