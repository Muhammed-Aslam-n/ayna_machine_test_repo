import 'package:ayna_machine_test/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ayna_machine_test/blocs/theme_bloc/theme_cubit.dart';
import 'package:ayna_machine_test/core/router/app_routes.dart';
import 'package:ayna_machine_test/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class DesktopHeader extends StatelessWidget {
  const DesktopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(
              "assets/messenger.png",
            ),
            width: 32,
            height: 32,
          ),
          const Expanded(child: SizedBox()),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 20,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            label: Text(
              "Search",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColor.primaryColor.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            splashRadius: 20,
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton(
            tooltip: "Profile Menu",
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 32),
                        child: Text(
                          "Profile",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    final theme = context.read<ThemeCubit>().state;

                    context.read<ThemeCubit>().changeThemeMode(
                        theme == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light);
                  },
                  child: Row(
                    children: [
                      Icon(context.read<ThemeCubit>().state == ThemeMode.dark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 32),
                        child: Text(
                          context.read<ThemeCubit>().state == ThemeMode.dark
                              ? "Light Mode"
                              : "Dark Mode",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: (){
                    context.pushNamed(AppRoutes.about.name);
                  },
                  child: Row(
                    children: [
                      const Icon(IconlyLight.info_circle),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 32),
                        child: Text(
                          "About",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    context.read<SignInBloc>().add(const SignOutRequired());
                  },
                  child: Row(
                    children: [
                      Icon(Icons.logout_outlined, color: AppColor.red),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 32),
                        child: Text(
                          "Logout",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColor.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            position: PopupMenuPosition.under,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/profile.jpg",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
