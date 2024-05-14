import 'package:ayna_machine_test/app_constants.dart';
import 'package:ayna_machine_test/app_view.dart';
import 'package:ayna_machine_test/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ayna_machine_test/blocs/chat_bloc/chat_bloc.dart';
import 'package:ayna_machine_test/blocs/theme_bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import 'blocs/chat_room_bloc/chat_room_cubit.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp(this.userRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Existing provider for AuthenticationBloc
        RepositoryProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          ),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(ThemeMode.light),
        ),
        BlocProvider<ChatRoomsCubit>(
          create: (context) => ChatRoomsCubit(),
        ),
        // Add the new provider for ChatBloc
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(
              WebSocketChannel.connect(Uri.parse(AppConstants.socketUrl))),
        ),
      ],
      child: const MyAppView(),
    );
  }
}
