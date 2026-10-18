import 'package:equatable/equatable.dart';
import 'package:tuku_shop/src/core/core.dart';

/// A notification the app raises itself, e.g. after an order is placed.
class NewNotification extends Equatable {
  final String title;
  final String body;
  final NotificationType type;
  final String? relatedItemId;

  const NewNotification({
    required this.title,
    required this.body,
    required this.type,
    this.relatedItemId,
  });

  @override
  List<Object?> get props => [title, body, type, relatedItemId];
}
