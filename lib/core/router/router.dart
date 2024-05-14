import 'package:ayna_machine_test/screens/about/presentation/about_section.dart';
import 'package:ayna_machine_test/screens/auth/sign_in_screen.dart';
import 'package:ayna_machine_test/screens/auth/sign_up_screen.dart';
import 'package:ayna_machine_test/screens/home/home_screen.dart';
import 'package:ayna_machine_test/screens/home/presentation/widget/chat_room_widget.dart';
import 'package:ayna_machine_test/screens/launch/launch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'app_routes.dart';

import 'package:go_router/go_router.dart';

/// Router configuration for application.
/// Whenever new views added, it should be configured here clearly.

final router = GoRouter(
  initialLocation: AppRoutes.launch.path,
  routes: [
    GoRoute(
      path: AppRoutes.launch.path,
      name: AppRoutes.launch.name,
      builder: (context, state) => const LaunchScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp.path,
      name: AppRoutes.signUp.name,
      pageBuilder: (context, state) => CupertinoPage(
        child: SignUpScreen(
          mobileScreen: state.extra != null ? state.extra as bool : true,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.signIn.path,
      name: AppRoutes.signIn.name,
      pageBuilder: (context, state) => CupertinoPage(
        child: SignInScreen(
          mobileScreen: state.extra != null ? state.extra as bool : true,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      pageBuilder: (context, state) => const CupertinoPage(
        child: HomeScreenLayoutWidget(),
      ),
    ),
    GoRoute(
      path: AppRoutes.chatRoom.path,
      name: AppRoutes.chatRoom.name,
      pageBuilder: (context, state) => const CupertinoPage(
        child: ChatRoomWidget(),
      ),
    ),
    GoRoute(
      path: AppRoutes.about.path,
      name: AppRoutes.about.name,
      pageBuilder: (context, state) => const CupertinoPage(
        child: AboutScreen(),
      ),
    ),
  ],
);
