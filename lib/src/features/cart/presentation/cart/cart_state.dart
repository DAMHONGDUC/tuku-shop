part of 'cart_controller.dart';

enum CartStatus { loading, loaded, error }

class CartState extends Equatable {
  final CartStatus status;
  final List<CartLine> lines;

  /// Bumped when a change failed and was rolled back.
  final int failureCount;

  const CartState({
    this.status = CartStatus.loading,
    this.lines = const [],
    this.failureCount = 0,
  });

  CartSummary get summary => CartSummary(lines);

  int get itemCount => summary.itemCount;

  CartState copyWith({
    CartStatus? status,
    List<CartLine>? lines,
    int? failureCount,
  }) {
    return CartState(
      status: status ?? this.status,
      lines: lines ?? this.lines,
      failureCount: failureCount ?? this.failureCount,
    );
  }

  @override
  List<Object?> get props => [status, lines, failureCount];
}
