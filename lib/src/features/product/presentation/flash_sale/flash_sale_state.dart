part of 'flash_sale_controller.dart';

class FlashSaleState extends Equatable {
  const FlashSaleState({this.status = LoadStatus.loading, this.sale});

  final LoadStatus status;
  final FlashSaleEntity? sale;

  @override
  List<Object?> get props => <Object?>[status, sale];
}
