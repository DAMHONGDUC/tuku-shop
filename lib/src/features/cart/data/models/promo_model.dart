class PromoModel {
  const PromoModel({
    this.code,
    this.percentOff,
    this.freeShipping,
    this.minSubtotal,
  });

  final String? code;
  final double? percentOff;
  final bool? freeShipping;
  final double? minSubtotal;
}
