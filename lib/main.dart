
import 'package:ayna_machine_test/app.dart';
import 'package:ayna_machine_test/app_constants.dart';
import 'package:ayna_machine_test/service/db_service/chat/chat_config.dart';
import 'package:ayna_machine_test/service/db_service/chat/model/chat_data_model.dart';
import 'package:ayna_machine_test/service/db_service/chat/model/chat_user_model.dart';
import 'package:ayna_machine_test/service/db_service/offline_chat_db/offline_chat_db_schema.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_repository/user_repository.dart';

import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: AppConstants.firebaseApiKey,
      appId: AppConstants.firebaseAppId,
      messagingSenderId: AppConstants.messagingSenderId,
      projectId: AppConstants.projectId,
      storageBucket: AppConstants.storageBucket,
    ),
  );

  Hive.registerAdapter(ChatUserProfileDBAdapter());
  Hive.registerAdapter(ChatDataModelAdapter());

  Hive.registerAdapter(OfflineChatDBSchemaAdapter());

  await Hive.initFlutter();

  await Hive.openBox<ChatDataModel>(AppConstants.chatDb);
  await Hive.openBox<ChatUserProfileDB>(AppConstants.chatUserDb);
  await Hive.openBox<OfflineChatDBSchema>(AppConstants.offlineChatDBName);


  await ChatDBServiceImpl().initBox();
  // await OfflineChatDBServiceImpl().initBox();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MyApp(
      FirebaseUserRepo(),
    ),
  );
}
