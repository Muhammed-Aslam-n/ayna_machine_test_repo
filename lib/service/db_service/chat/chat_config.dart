
import 'package:ayna_machine_test/service/db_service/chat/model/chat_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../app_constants.dart';

abstract class ChatDBService {
  Future<void> storeMessage(ChatDataModel chatData);

  ValueListenable<Box<ChatDataModel>> get messagesStream;
}


class ChatDBServiceImpl extends ChatDBService {
  Box<ChatDataModel>? _messageBox;

  ChatDBServiceImpl._internal(); // Private constructor

  static final ChatDBServiceImpl _instance = ChatDBServiceImpl._internal();

  factory ChatDBServiceImpl() {
    return _instance; // Return the same instance
  }

  initBox() {
    _messageBox = Hive.box<ChatDataModel>(AppConstants.chatDb);
  }

  @override
  Future<int?> storeMessage(ChatDataModel chatData) async {
    final res = await _messageBox?.add(
        chatData
    );
    debugPrint('resultOfStoreMessage $res');
    return res;
  }

  @override
  ValueListenable<Box<ChatDataModel>> get messagesStream {
    if (_messageBox == null) {
      debugPrint('MainDBIsEmpty');
      _messageBox = Hive.box<ChatDataModel>(AppConstants.chatDb);

      return _messageBox!.listenable();
    }
    return _messageBox!.listenable();
    // return _messageBox!.watch().map((event) => event.value.toList());
  }


}