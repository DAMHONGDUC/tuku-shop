import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/support_chat/data/data_sources/support_chat_local_data_source.dart';
import 'package:tuku_shop/src/features/support_chat/data/repositories/support_chat_repository_impl.dart';
import 'package:tuku_shop/src/features/support_chat/domain/domain.dart';
import 'package:tuku_shop/src/features/support_chat/presentation/support_chat/support_chat_controller.dart';

class SupportChatDi {
  static config() {
    getIt.registerLazySingleton<SupportChatLocalDataSource>(
      () => SupportChatLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<SupportChatRepository>(
      () => SupportChatRepositoryImpl(
        dataSource: getIt<SupportChatLocalDataSource>(),
      ),
    );
    getIt.registerLazySingleton<GetSupportMessagesUsecase>(
      () => GetSupportMessagesUsecase(getIt<SupportChatRepository>()),
    );
    getIt.registerLazySingleton<SendSupportMessageUsecase>(
      () => SendSupportMessageUsecase(getIt<SupportChatRepository>()),
    );
    getIt.registerLazySingleton<WatchSupportMessagesUsecase>(
      () => WatchSupportMessagesUsecase(getIt<SupportChatRepository>()),
    );
    getIt.registerLazySingleton<ResetSupportChatUsecase>(
      () => ResetSupportChatUsecase(getIt<SupportChatRepository>()),
    );

    getIt.registerFactory<SupportChatController>(
      () => SupportChatController(
        getIt<GetSupportMessagesUsecase>(),
        getIt<SendSupportMessageUsecase>(),
        getIt<WatchSupportMessagesUsecase>(),
      ),
    );
  }
}
