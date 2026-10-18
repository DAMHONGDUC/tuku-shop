import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/profile/presentation/profile/profile_controller.dart';

class _GetUser extends Mock implements GetCurrentUserUsecase {}

class _GetCounts extends Mock implements GetOrderCountsUsecase {}

class _WatchOrders extends Mock implements WatchOrderChangesUsecase {}

class _Logout extends Mock implements LogoutUsecase {}

class _Reset extends Mock implements UseCase<Unit, NoParams> {}

void main() {
  late _GetUser getUser;
  late _GetCounts getCounts;
  late _Logout logout;
  late List<_Reset> resets;
  late StreamController<void> orderChanges;
  late ProfileController controller;

  const user = UserEntity(
    id: 'u',
    fullName: 'Tuku Demo',
    email: 'demo@tukushop.com',
    phone: '1',
    avatarUrl: '',
  );

  setUp(() {
    getUser = _GetUser();
    getCounts = _GetCounts();
    final watch = _WatchOrders();
    logout = _Logout();
    resets = [_Reset(), _Reset()];
    orderChanges = StreamController.broadcast();
    when(() => watch()).thenAnswer((_) => orderChanges.stream);
    when(
      () => getUser.call(NoParams()),
    ).thenAnswer((_) async => const Right(user));
    when(
      () => getCounts.call(NoParams()),
    ).thenAnswer((_) async => const Right({OrderStatus.delivered: 6}));
    for (final r in resets) {
      when(() => r.call(NoParams())).thenAnswer((_) async => const Right(unit));
    }
    controller = ProfileController(
      getCurrentUser: getUser,
      getOrderCounts: getCounts,
      watchOrderChanges: watch,
      logout: logout,
      resetSteps: resets,
    );
  });

  tearDown(() async {
    await controller.close();
    await orderChanges.close();
  });

  test('load fills the user and the counters', () async {
    await controller.load();
    expect(controller.state.user, user);
    expect(controller.state.counts[OrderStatus.delivered], 6);
  });

  test('counters refresh when an order changes', () async {
    await controller.load();
    when(
      () => getCounts.call(NoParams()),
    ).thenAnswer((_) async => const Right({OrderStatus.delivered: 7}));
    orderChanges.add(null);
    await Future<void>.delayed(Duration.zero);
    expect(controller.state.counts[OrderStatus.delivered], 7);
  });

  test('reset runs every step once', () async {
    await controller.resetDemoData();
    for (final r in resets) {
      verify(() => r.call(NoParams())).called(1);
    }
    expect(controller.state.resets, 1);
    expect(controller.state.isResetting, isFalse);
  });

  test('logout flags the state', () async {
    when(
      () => logout.call(NoParams()),
    ).thenAnswer((_) async => const Right(unit));
    await controller.logout();
    expect(controller.state.loggedOut, isTrue);
  });
}
