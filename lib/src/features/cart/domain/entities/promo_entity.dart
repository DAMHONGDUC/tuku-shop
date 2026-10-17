import 'package:equatable/equatable.dart';

class PromoEntity extends Equatable {
  const PromoEntity({
    required this.code,
    this.percentOff = 0,
    this.freeShipping = false,
    this.minSubtotal = 0,
  });

  final String code;

  /// 0.1 for 10% off the subtotal.
  final double percentOff;
  final bool freeShipping;
  final double minSubtotal;

  @override
  List<Object> get props => <Object>[code, percentOff, freeShipping, minSubtotal];
}
