import 'package:ayna_machine_test/blocs/chat_room_bloc/chat_room_cubit.dart';
import 'package:ayna_machine_test/core/component/widgets/responsive_screen.dart';
import 'package:ayna_machine_test/screens/home/presentation/widget/chats_widget.dart';
import 'package:ayna_machine_test/screens/home/model/chat_room.dart';
import 'package:ayna_machine_test/screens/home/presentation/widget/desktop/desktop_header.dart';
import 'package:ayna_machine_test/screens/home/presentation/widget/mobile/mobile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'presentation/widget/chat_room_widget.dart';



class HomeScreenLayoutWidget extends StatelessWidget {
  const HomeScreenLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ResponsiveScreen(
          mobile: MobileLayout(),
          tablet: DesktopLayout(),
          dekstop: DesktopLayout(),
        ),
      ),
    );
  }
}

Future<bool> doubleBackExit(BuildContext context) async{
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    // Show a snackbar or toast to inform the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Press back again to exit'),
        duration: Duration(seconds: 2),
      ),
    );
    return Future.value(false);
  }
  return Future.value(true);
}


DateTime? currentBackPressTime;


class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomsCubit, ChatRoom?>(
      builder: (context, state) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              MobileHeader(),
              Expanded(
                child: ChatsWidget(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DesktopHeader(),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            "All Messages",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: const Row(
              children:  [
                Expanded(
                  flex: 3,
                  child: ChatsWidget(),
                ),
                VerticalDivider(),
                Expanded(
                  flex: 7,
                  child: ChatRoomWidget(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



showToast(
  BuildContext context,
  String message, {
  Color? messageColor,
  Color? bgColor,
  Color? textColor,
  bool info = false,
  success = false,
  failure = false,
  Duration? duration,
}) {
  if (context.mounted) {
    final SnackBar snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: info
            ? Colors.orange
            : success
                ? Colors.green
                : failure
                    ? Colors.redAccent
                    : bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: Text(
          message,
          style: TextStyle(color: messageColor ?? Colors.white),
        ));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}



// Display list of messages using BlocBuilder
// BlocBuilder<ChatBloc, ChatState>(
//   builder: (context, state) {
//     if (state is MessagesReceivedState) {
//       return ListView.builder(
//         shrinkWrap: true,
//         itemCount: state.messages.length,
//         itemBuilder: (context, index) =>
//             Text(state.messages[index]),
//       );
//     } else {
//       return const Text("No messages yet");
//     }
//   },
// ),

// StreamBuilder(stream: ChatDBServiceImpl().messagesStream  , builder: (builder,stream){
//   if(stream.hasError){
//
//     return Text('Some error occurred');
//   }
//   if(stream.hasData && stream.data !=null){
//     return Text(stream.data!.last);
//     return stream.data!.map((e) => Text(e)) as Widget;
//   }
//   return Text('Nothing from DB');
// }),
