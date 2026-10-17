class NotificationModel {
  const NotificationModel({
    this.id,
    this.type,
    this.title,
    this.body,
    this.createdAt,
    this.isRead,
    this.image,
    this.link,
  });

  final String? id;
  final String? type;
  final String? title;
  final String? body;
  final DateTime? createdAt;
  final bool? isRead;
  final String? image;
  final String? link;

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
    id: id,
    type: type,
    title: title,
    body: body,
    createdAt: createdAt,
    isRead: isRead ?? this.isRead,
    image: image,
    link: link,
  );
}
