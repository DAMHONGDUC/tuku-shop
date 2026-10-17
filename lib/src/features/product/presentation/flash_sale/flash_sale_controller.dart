import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

part 'flash_sale_state.dart';

class FlashSaleController extends Cubit<FlashSaleState> {
  FlashSaleController(this._getFlashSale) : super(const FlashSaleState());

  final GetFlashSaleUsecase _getFlashSale;

  Future<void> load() async {
    emit(const FlashSaleState());

    final Either<Failure, FlashSaleEntity> result = await _getFlashSale(
      const NoParams(),
    );

    result.fold(
      (Failure _) => emit(const FlashSaleState(status: LoadStatus.failure)),
      (FlashSaleEntity sale) =>
          emit(FlashSaleState(status: LoadStatus.success, sale: sale)),
    );
  }
}
