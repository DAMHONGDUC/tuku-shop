import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

class TrackingEventEntity extends Equatable {
  const TrackingEventEntity({
    required this.status,
    required this.time,
    required this.location,
  });

  final OrderStatus status;
  final DateTime time;
  final String location;

  @override
  List<Object> get props => <Object>[status, time, location];
}
