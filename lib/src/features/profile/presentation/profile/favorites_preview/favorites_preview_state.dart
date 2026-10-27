part of 'favorites_preview_controller.dart';

enum FavoritesPreviewStatus { loading, loaded, error }

class FavoritesPreviewState extends Equatable {
  final FavoritesPreviewStatus status;

  /// At most [FavoritesPreviewController.limit], newest first.
  final List<ProductEntity> products;

  /// Every saved product, not only the ones shown.
  final int total;

  const FavoritesPreviewState({
    this.status = FavoritesPreviewStatus.loading,
    this.products = const [],
    this.total = 0,
  });

  FavoritesPreviewState copyWith({FavoritesPreviewStatus? status}) {
    return FavoritesPreviewState(
      status: status ?? this.status,
      products: products,
      total: total,
    );
  }

  @override
  List<Object?> get props => [status, products, total];
}
