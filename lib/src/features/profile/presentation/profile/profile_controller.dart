import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/order/domain/domain.dart';

part 'profile_state.dart';

/// The Profile tab's own numbers. Who is signed in comes from the session,
/// the saved count from the wishlist; only the order count is fetched here.
class ProfileController extends Cubit<ProfileState> {
  ProfileController({required this._getOrders}) : super(const ProfileState());

  final GetOrdersUsecase _getOrders;

  Future<void> load() async {
    final Either<Failure, List<OrderEntity>> result = await _getOrders(
      const NoParams(),
    );
    result.fold(
      (Failure _) => emit(state.copyWith(status: LoadStatus.failure)),
      (List<OrderEntity> orders) => emit(
        state.copyWith(status: LoadStatus.success, orderCount: orders.length),
      ),
    );
  }
}
