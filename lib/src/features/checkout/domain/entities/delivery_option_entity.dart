import 'package:equatable/equatable.dart';

class DeliveryOptionEntity extends Equatable {
  const DeliveryOptionEntity({
    required this.id,
    required this.minDays,
    required this.maxDays,
    required this.fee,
    this.freeOverThreshold = false,
  });

  /// `standard`, `express`, `nextDay` — the UI names it from the id.
  final String id;
  final int minDays;
  final int maxDays;
  final double fee;

  /// Waived when the bag qualifies for free shipping.
  final bool freeOverThreshold;

  double feeFor({required bool qualifiesForFree}) =>
      freeOverThreshold && qualifiesForFree ? 0 : fee;

  @override
  List<Object> get props => <Object>[id, minDays, maxDays, fee, freeOverThreshold];
}
