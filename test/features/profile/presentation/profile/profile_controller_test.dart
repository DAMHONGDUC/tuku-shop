import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/profile_controller.dart';

import '../../../../helpers/fixtures.dart';
import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetOrdersUsecase getOrders;

  setUp(() => getOrders = MockGetOrdersUsecase());

  blocTest<ProfileController, ProfileState>(
    'load counts the orders',
    build: () {
      when(() => getOrders(const NoParams())).thenAnswer(
        (_) async => Right<Failure, List<OrderEntity>>(<OrderEntity>[
          Fixtures.order(id: 'o_1'),
          Fixtures.order(id: 'o_2'),
        ]),
      );
      return ProfileController(getOrders: getOrders);
    },
    act: (ProfileController c) => c.load(),
    expect: () => <ProfileState>[
      const ProfileState(status: LoadStatus.success, orderCount: 2),
    ],
  );

  blocTest<ProfileController, ProfileState>(
    'a failed load keeps the last count',
    build: () {
      when(() => getOrders(const NoParams())).thenAnswer(
        (_) async => const Left<Failure, List<OrderEntity>>(ServerFailure()),
      );
      return ProfileController(getOrders: getOrders);
    },
    seed: () => const ProfileState(status: LoadStatus.success, orderCount: 3),
    act: (ProfileController c) => c.load(),
    expect: () => <ProfileState>[
      const ProfileState(status: LoadStatus.failure, orderCount: 3),
    ],
  );
}
