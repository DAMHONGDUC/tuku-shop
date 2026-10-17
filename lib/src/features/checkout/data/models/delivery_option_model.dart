class DeliveryOptionModel {
  const DeliveryOptionModel({
    this.id,
    this.minDays,
    this.maxDays,
    this.fee,
    this.freeOverThreshold,
  });

  final String? id;
  final int? minDays;
  final int? maxDays;
  final double? fee;
  final bool? freeOverThreshold;
}
