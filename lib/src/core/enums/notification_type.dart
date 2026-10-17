enum NotificationType {
  order,
  promotion,
  newArrival,
  account;

  static NotificationType fromName(String? value) =>
      NotificationType.values.firstWhere(
        (NotificationType e) => e.name == value,
        orElse: () => NotificationType.account,
      );
}
