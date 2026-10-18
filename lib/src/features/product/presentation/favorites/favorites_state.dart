part of 'favorites_controller.dart';

class FavoritesState extends Equatable {
  final Set<String> ids;

  /// Bumped when a toggle failed and was rolled back, so the UI can say so.
  final int failureCount;

  const FavoritesState({this.ids = const {}, this.failureCount = 0});

  bool contains(String productId) => ids.contains(productId);

  @override
  List<Object?> get props => [ids, failureCount];
}
