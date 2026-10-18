import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/presentation/notifications/notifications_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_usecases.dart';

void main() {
  late MockGetNotificationsUsecase usecase;
  late NotificationsController controller;
  late MockMarkAllNotificationsReadUsecase markRead;

  final tNotificationData = NotificationData(
    listNotification: const [],
    listNotificationCategory: const [],
  );

  setUp(() {
    usecase = MockGetNotificationsUsecase();
    markRead = MockMarkAllNotificationsReadUsecase();
    when(
      () => markRead.call(NoParams()),
    ).thenAnswer((_) async => const Right(unit));
    controller = NotificationsController(usecase, markRead);
  });

  tearDown(() => controller.close());

  blocTest<NotificationsController, NotificationsState>(
    'emits [Loading, Loaded] when the usecase succeeds',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => Right(tNotificationData));
    },
    build: () => controller,
    act: (c) => c.getData(),
    expect: () => [
      NotificationsLoadingState(),
      NotificationsLoadedState(notificationData: tNotificationData),
    ],
  );

  blocTest<NotificationsController, NotificationsState>(
    'emits [Loading, Error] when the usecase fails',
    setUp: () {
      when(
        () => usecase.call(NoParams()),
      ).thenAnswer((_) async => Left(ServerFailure()));
    },
    build: () => controller,
    act: (c) => c.getData(),
    expect: () => [
      NotificationsLoadingState(),
      NotificationsErrorState(errorMsg: 'something wrong'),
    ],
  );

  test('selectFilter narrows the visible list', () async {
    final data = NotificationData(
      listNotification: [
        NotificationEntity(
          id: '1',
          title: 'Shipped',
          body: '',
          timestamp: DateTime(2026),
          type: NotificationType.orderUpdate,
        ),
        NotificationEntity(
          id: '2',
          title: 'Sale',
          body: '',
          timestamp: DateTime(2026),
          type: NotificationType.promotion,
        ),
      ],
      listNotificationCategory: const [],
    );
    when(() => usecase.call(NoParams())).thenAnswer((_) async => Right(data));

    await controller.getData();
    controller.selectFilter(NotificationFilter.offers);

    final state = controller.state as NotificationsLoadedState;
    expect(state.visible.map((e) => e.id), ['2']);
  });
}
