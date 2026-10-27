import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/address/data/data_sources/address_local_data_source.dart';
import 'package:tuku_shop/src/features/address/data/repositories/address_repository_impl.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/address/presentation/address_book/address_book_controller.dart';
import 'package:tuku_shop/src/features/address/presentation/address_form/address_form_controller.dart';

class AddressDi {
  static config() {
    getIt.registerLazySingleton<AddressLocalDataSource>(
      () => AddressLocalDataSourceImpl(),
    );
    getIt.registerLazySingleton<AddressRepository>(
      () => AddressRepositoryImpl(dataSource: getIt<AddressLocalDataSource>()),
    );
    getIt.registerLazySingleton<GetAddressesUsecase>(
      () => GetAddressesUsecase(getIt<AddressRepository>()),
    );
    getIt.registerLazySingleton<SaveAddressUsecase>(
      () => SaveAddressUsecase(getIt<AddressRepository>()),
    );
    getIt.registerLazySingleton<DeleteAddressUsecase>(
      () => DeleteAddressUsecase(getIt<AddressRepository>()),
    );
    getIt.registerLazySingleton<SetDefaultAddressUsecase>(
      () => SetDefaultAddressUsecase(getIt<AddressRepository>()),
    );
    getIt.registerLazySingleton<ResetAddressesUsecase>(
      () => ResetAddressesUsecase(getIt<AddressRepository>()),
    );
    getIt.registerFactory<AddressBookController>(
      () => AddressBookController(
        getIt<GetAddressesUsecase>(),
        getIt<SetDefaultAddressUsecase>(),
        getIt<DeleteAddressUsecase>(),
      ),
    );
    getIt.registerFactory<AddressFormController>(
      () => AddressFormController(getIt<SaveAddressUsecase>()),
    );
  }
}
