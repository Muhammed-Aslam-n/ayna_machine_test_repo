import 'package:ayna_machine_test/core/router/router.dart';
import 'package:ayna_machine_test/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'blocs/theme_bloc/theme_cubit.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ayana AI - Machine Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      themeMode: context.watch<ThemeCubit>().state,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child:child!,
          breakpoints: const [
            Breakpoint(start: 0, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1000, name: TABLET),
            Breakpoint(start: 1001, end: 1200, name: DESKTOP),
            Breakpoint(start: 1201, end: double.infinity, name: '4K'),
          ],
        );
      },

    );
  }
}
