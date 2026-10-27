import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:tuku_shop/src/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:tuku_shop/src/features/chat/domain/domain.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_badge/chat_unread_controller.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_list/chat_list_controller.dart';
import 'package:tuku_shop/src/features/chat/presentation/chat_thread/chat_thread_controller.dart';
import 'package:tuku_shop/src/features/seller/domain/domain.dart';

class ChatDi {
  static config() {
    getIt.registerLazySingleton<ChatLocalDataSource>(
      () => ChatLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(dataSource: getIt<ChatLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetConversationsUsecase>(
      () => GetConversationsUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<WatchConversationsUsecase>(
      () => WatchConversationsUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<OpenConversationUsecase>(
      () => OpenConversationUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<GetChatMessagesUsecase>(
      () => GetChatMessagesUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<WatchChatMessagesUsecase>(
      () => WatchChatMessagesUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<SendChatMessageUsecase>(
      () => SendChatMessageUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<MarkConversationReadUsecase>(
      () => MarkConversationReadUsecase(getIt<ChatRepository>()),
    );
    getIt.registerLazySingleton<ResetChatUsecase>(
      () => ResetChatUsecase(getIt<ChatRepository>()),
    );

    // App-wide, like the notification badge.
    getIt.registerLazySingleton<ChatUnreadController>(
      () => ChatUnreadController(
        getIt<GetConversationsUsecase>(),
        getIt<WatchConversationsUsecase>(),
      ),
    );
    getIt.registerFactory<ChatListController>(
      () => ChatListController(
        getIt<GetConversationsUsecase>(),
        getIt<WatchConversationsUsecase>(),
        getIt<GetSellersByIdsUsecase>(),
      ),
    );
    getIt.registerFactory<ChatThreadController>(
      () => ChatThreadController(
        getIt<OpenConversationUsecase>(),
        getIt<GetChatMessagesUsecase>(),
        getIt<WatchChatMessagesUsecase>(),
        getIt<SendChatMessageUsecase>(),
        getIt<MarkConversationReadUsecase>(),
        getIt<GetSellerUsecase>(),
      ),
    );
  }
}
