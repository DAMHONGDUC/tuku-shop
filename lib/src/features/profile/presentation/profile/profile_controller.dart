import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';
import 'package:tuku_shop/src/features/cart/domain/domain.dart';
import 'package:tuku_shop/src/features/notification/domain/domain.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/wishlist/domain/domain.dart';

part 'profile_state.dart';

/// The Profile tab: the user and the order counters load separately.
class ProfileController extends Cubit<ProfileState> {
  ProfileController({
    required GetCurrentUserUsecase getCurrentUser,
    required GetOrderCountsUsecase getOrderCounts,
    required WatchOrderChangesUsecase watchOrderChanges,
    required LogoutUsecase logout,
    required List<UseCase<Unit, NoParams>> resetSteps,
  }) : _getCurrentUser = getCurrentUser,
       _getOrderCounts = getOrderCounts,
       _logout = logout,
       _resetSteps = resetSteps,
       super(const ProfileState()) {
    _subscription = watchOrderChanges().listen((_) => loadCounts());
  }

  final GetCurrentUserUsecase _getCurrentUser;
  final GetOrderCountsUsecase _getOrderCounts;
  final LogoutUsecase _logout;

  /// Each feature's own reset: cart, wishlist, orders, addresses,
  /// notifications, search history.
  final List<UseCase<Unit, NoParams>> _resetSteps;
  late final StreamSubscription<void> _subscription;

  Future<void> load() => Future.wait([loadUser(), loadCounts()]);

  Future<void> loadUser() async {
    emit(state.copyWith(userStatus: ProfileSectionStatus.loading));
    final result = await _getCurrentUser.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(userStatus: ProfileSectionStatus.error)),
      (user) => emit(
        state.copyWith(userStatus: ProfileSectionStatus.loaded, user: user),
      ),
    );
  }

  Future<void> loadCounts() async {
    final result = await _getOrderCounts.call(NoParams());
    if (isClosed) return;
    result.fold(
      (_) => emit(state.copyWith(countsStatus: ProfileSectionStatus.error)),
      (counts) => emit(
        state.copyWith(
          countsStatus: ProfileSectionStatus.loaded,
          counts: counts,
        ),
      ),
    );
  }

  void showUser(UserEntity user) =>
      emit(state.copyWith(userStatus: ProfileSectionStatus.loaded, user: user));

  /// Puts every store back to the first-launch demo data.
  Future<void> resetDemoData() async {
    if (state.isResetting) return;
    emit(state.copyWith(isResetting: true));
    await Future.wait([for (final step in _resetSteps) step.call(NoParams())]);
    emit(state.copyWith(isResetting: false, resets: state.resets + 1));
  }

  Future<void> logout() async {
    final result = await _logout.call(NoParams());
    result.fold(
      (_) => emit(state.copyWith(logoutFailed: true)),
      (_) => emit(state.copyWith(loggedOut: true)),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}

/// The reset steps, in no particular order.
List<UseCase<Unit, NoParams>> demoResetSteps({
  required ResetCartUsecase cart,
  required ResetWishlistUsecase wishlist,
  required ResetOrdersUsecase orders,
  required ResetAddressesUsecase addresses,
  required ResetNotificationsUsecase notifications,
  required ClearRecentSearchesUsecase searches,
}) => [cart, wishlist, orders, addresses, notifications, searches];
