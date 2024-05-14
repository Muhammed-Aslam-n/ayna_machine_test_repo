import 'package:ayna_machine_test/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ayna_machine_test/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:ayna_machine_test/screens/auth/welcome_screen.dart';
import 'package:ayna_machine_test/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider(
            create: (context) => SignInBloc(
                userRepository:
                context.read<AuthenticationBloc>().userRepository),
            child: const HomeScreenLayoutWidget(),
          );
        } else {
          return const WelcomeView();
        }
      },
    );
  }
}
