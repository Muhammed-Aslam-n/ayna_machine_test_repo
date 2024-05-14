// ignore_for_file: deprecated_member_use

import 'package:ayna_machine_test/blocs/chat_bloc/chat_bloc.dart';
import 'package:ayna_machine_test/screens/home/home_screen.dart';
import 'package:ayna_machine_test/screens/home/model/chat_room.dart';
import 'package:ayna_machine_test/screens/home/presentation/widget/chat_field_widget.dart';
import 'package:ayna_machine_test/service/connectivity/connectivity_service.dart';
import 'package:ayna_machine_test/service/db_service/chat/chat_config.dart';
import 'package:ayna_machine_test/service/db_service/chat/model/chat_data_model.dart';
import 'package:ayna_machine_test/widgets/overlay_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../blocs/chat_room_bloc/chat_room_cubit.dart';
import '../../../../service/db_service/offline_chat_db/offline_chat_config.dart';
import '../../../../theme/app_color.dart';

class ChatRoomWidget extends StatefulWidget {
  const ChatRoomWidget({
    super.key,
    this.showBackButton = false,
  });

  final bool showBackButton;

  @override
  State<ChatRoomWidget> createState() => _ChatRoomWidgetState();
}

class _ChatRoomWidgetState extends State<ChatRoomWidget> {
  final _messageController = TextEditingController();

  final _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent + 60,
      );
    }
  }


  checkIfOfflineDataExist() async {
    if (await ConnectivityService.isAvailable() &&
        !OfflineChatDBServiceImpl().isDbEmpty &&
        context.mounted) {
      context.read<ChatBloc>().add(const SyncOfflineMessagesEvent());
    }
  }

  @override
  void initState() {
    checkIfOfflineDataExist();
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Schedule _scrollToBottom after the widget tree has built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatRoomsCubit>().unSelectRoom();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<ChatRoomsCubit, ChatRoom?>(
            builder: (context, state) {
              if (state == null) {
                return const Center(
                  child: Text("Select a chat to start Messaging!"),
                );
              }
              return BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, chatState) {
                if (chatState is ChatErrorState) {
                  showToast(context, chatState.error, success: false);
                }
                if (chatState is ChatSyncingState) {
                  LoadingScreen.instance().show(
                    context: context,
                    text: 'Please wait, Syncing old messages',
                  );
                }
                if (chatState is ChatSyncedState) {
                  LoadingScreen.instance().hide();
                }
                if (chatState is ChatSyncFailedState) {
                  LoadingScreen.instance().hide();
                  showToast(context, 'Sync failed!', success: false);
                }
              }, builder: (context, chatState) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (widget.showBackButton) ...[
                            IconButton(
                              onPressed: () {
                                context.read<ChatRoomsCubit>().unSelectRoom();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20,
                              ),
                              splashRadius: 20,
                            ),
                            const SizedBox(width: 16),
                          ],
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  state.picture,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.name,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  state.username,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder<Box<ChatDataModel>>(
                        valueListenable: ChatDBServiceImpl().messagesStream,
                        builder: (builder, chatData, _) {
                          if (chatData.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          final keys = chatData.keys
                              .cast<int>()
                              .where((key) =>
                                  chatData.get(key)?.senderId == state.id)
                              .toList();
        
                          if(keys.isEmpty){
                            return const Center(
                              child: Text('Send your first message!'),
                            );
                          }
        
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              final chat = chatData.get(keys[index]);
        
                              if (chat!.sentByUser) {
                                return sentMessageWidget(
                                  context,
                                  message: chat.message,
                                  dateTime: chat.messageTimestamp.toString(),
                                );
                              }
                              return receivedMessagesWidget(
                                context,
                                message: chat.message,
                                dateTime: chat.messageTimestamp.toString(),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                            itemCount: chatData.length,
                          );
                        },
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     reverse: true,
                    //     padding: const EdgeInsets.all(24),
                    //     itemCount: state.chats.length,
                    //     itemBuilder: (context, index) {
                    //       Chat? chat = state.chats[index];
                    //       Chat? nextChat;
                    //
                    //       if (index != (state.chats.length ?? 0) - 1) {
                    //         nextChat = state.chats[index + 1];
                    //       }
                    //
                    //       return Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           /// time stamp, only show in top of each day
                    //           if (chat.messageTimestamp.simpleFormat !=
                    //               nextChat?.messageTimestamp.simpleFormat)
                    //             Align(
                    //               alignment: Alignment.center,
                    //               child: Container(
                    //                 padding: const EdgeInsets.symmetric(
                    //                   horizontal: 16,
                    //                   vertical: 8,
                    //                 ),
                    //                 margin: const EdgeInsets.symmetric(
                    //                   vertical: 8,
                    //                 ),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(16),
                    //                   color:
                    //                       AppColor.primaryColor.withOpacity(0.1),
                    //                 ),
                    //                 child: Text(
                    //                   chat.messageTimestamp.simpleFormat ?? "",
                    //                   style:
                    //                       Theme.of(context).textTheme.bodySmall,
                    //                 ),
                    //               ),
                    //             ),
                    //
                    //           if (chat.senderId == myId)
                    //             Align(
                    //               alignment: Alignment.centerRight,
                    //               child: MyChat(chat: chat),
                    //             ),
                    //
                    //           if (chat.senderId != myId)
                    //             Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: OthersChat(chat: chat),
                    //             ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.emoji_emotions_outlined,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            onPressed: () {},
                            splashRadius: 20,
                            icon: const Icon(
                              CupertinoIcons.photo,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              onTapOutside: (k) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              minLines: 1,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Message....",
                              ),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            onPressed: () {
                              if (_messageController.text.isNotEmpty) {
                                context.read<ChatBloc>().add(
                                      SendMessageEvent(
                                        ChatDataModel(
                                          senderId: state.id,
                                          senderName: state.name,
                                          message: _messageController.text,
                                          messageTimestamp: DateTime.now(),
                                          sentByUser: true
                                        ),
                                      ),
                                    );
                                _messageController.clear();
                                _scrollToBottom();
                                setState(() {});
                              }
                            },
                            splashRadius: 20,
                            icon: const Icon(
                              CupertinoIcons.paperplane,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
            },
          ),
        ),
      ),
    );
  }
}

class MyChat extends StatelessWidget {
  const MyChat({super.key, this.chat});

  final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            color: AppColor.primaryColor,
          ),
          child: Text(
            chat?.message ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColor.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${chat?.messageTimestamp.hour ?? "-"}:${chat?.messageTimestamp.minute ?? "-"}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.done_all,
                size: 18,
                color: Colors.blue,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OthersChat extends StatelessWidget {
  const OthersChat({super.key, this.chat});

  final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width / 2,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: AppColor.primaryColor.withOpacity(0.2),
          ),
          child: Text(
            chat?.message ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 16),
          child: Text(
            "${chat?.messageTimestamp.hour ?? "-"}:${chat?.messageTimestamp.minute ?? "-"}",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
