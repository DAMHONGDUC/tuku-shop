import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.isRead,
    this.image,
    this.link,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool isRead;
  final String? image;

  /// An in-app location to open on tap — `/orders/o_1031`.
  final String? link;

  NotificationEntity copyWith({bool? isRead}) => NotificationEntity(
    id: id,
    type: type,
    title: title,
    body: body,
    createdAt: createdAt,
    isRead: isRead ?? this.isRead,
    image: image,
    link: link,
  );

  @override
  List<Object?> get props => <Object?>[
    id,
    type,
    title,
    body,
    createdAt,
    isRead,
    image,
    link,
  ];
}
