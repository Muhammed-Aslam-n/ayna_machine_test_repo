import 'package:ayna_machine_test/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

import 'offline_chat_db_schema.dart';

abstract class OfflineChatDBService {
  Future<void> storeMessage(OfflineChatDBSchema offlineChatData);

  ValueListenable<Box<OfflineChatDBSchema>> get messagesStream;
}

class OfflineChatDBServiceImpl extends OfflineChatDBService {
  Box<OfflineChatDBSchema>? _offlineMessageBox;

  OfflineChatDBServiceImpl._internal() {
    _offlineMessageBox =
        Hive.box<OfflineChatDBSchema>(AppConstants.offlineChatDBName);
  } // Private constructor

  static final OfflineChatDBServiceImpl _instance =
      OfflineChatDBServiceImpl._internal();

  factory OfflineChatDBServiceImpl() {
    return _instance; // Return the same instance
  }

  initBox() {
    _offlineMessageBox =
        Hive.box<OfflineChatDBSchema>(AppConstants.offlineChatDBName);
  }

  @override
  ValueListenable<Box<OfflineChatDBSchema>> get messagesStream {
    if (_offlineMessageBox == null) {
      debugPrint('OfflineDBIsEmpty');
      _offlineMessageBox =
          Hive.box<OfflineChatDBSchema>(AppConstants.offlineChatDBName);

      return _offlineMessageBox!.listenable();
    }
    return _offlineMessageBox!.listenable();
  }

  @override
  Future<int?> storeMessage(OfflineChatDBSchema offlineChatData) async {
    try {
      final res = await _offlineMessageBox?.add(offlineChatData);
      debugPrint('resultOfStoreMessage $res');
      return res;
    } catch (e) {
      return null;
    }
  }

  bool get isDbEmpty {
    _offlineMessageBox = _offlineMessageBox ??
        Hive.box<OfflineChatDBSchema>(AppConstants.chatDBName);
    return _offlineMessageBox!.isEmpty;
  }

  clearOfflineDB() async {
    try {
      return await _offlineMessageBox!.clear();
    } catch (e) {
      return null;
    }
  }
}
