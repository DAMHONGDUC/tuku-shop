part of 'shop_header_controller.dart';

enum ShopHeaderStatus { loading, loaded, error }

class ShopHeaderState extends Equatable {
  final ShopHeaderStatus status;
  final Seller? seller;

  /// Null when the count could not be read; the stat then shows a dash.
  final int? productCount;
  final bool isTogglingFollow;

  /// Bumped when Follow failed, for the error toast.
  final int failureCount;

  const ShopHeaderState({
    this.status = ShopHeaderStatus.loading,
    this.seller,
    this.productCount,
    this.isTogglingFollow = false,
    this.failureCount = 0,
  });

  ShopHeaderState copyWith({
    Seller? seller,
    bool? isTogglingFollow,
    int? failureCount,
  }) {
    return ShopHeaderState(
      status: status,
      seller: seller ?? this.seller,
      productCount: productCount,
      isTogglingFollow: isTogglingFollow ?? this.isTogglingFollow,
      failureCount: failureCount ?? this.failureCount,
    );
  }

  @override
  List<Object?> get props => [
    status,
    seller,
    productCount,
    isTogglingFollow,
    failureCount,
  ];
}
