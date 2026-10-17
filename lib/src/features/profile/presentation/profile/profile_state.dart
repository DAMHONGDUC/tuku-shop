part of 'profile_controller.dart';

class ProfileState extends Equatable {
  const ProfileState({this.status = LoadStatus.loading, this.orderCount = 0});

  final LoadStatus status;
  final int orderCount;

  ProfileState copyWith({LoadStatus? status, int? orderCount}) => ProfileState(
    status: status ?? this.status,
    orderCount: orderCount ?? this.orderCount,
  );

  @override
  List<Object> get props => <Object>[status, orderCount];
}
