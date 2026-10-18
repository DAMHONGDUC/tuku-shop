import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_category_model.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationsMock {
  static List<NotificationCategoryModel> generateMockCategories() {
    return [
      NotificationCategoryModel(
        name: 'Promotions',
        description: 'Updates on deals and vouchers',
        icon: Icons.local_offer,
        type: NotificationCategoryType.promotion,
        numOfNotifications: 3,
      ),
      NotificationCategoryModel(
        name: 'Live & Video',
        description: 'Updates from Live Streams and video content',
        icon: Icons.live_tv,
        type: NotificationCategoryType.liveVideo,
        numOfNotifications: 0,
      ),
      NotificationCategoryModel(
        name: 'Financial Info',
        description: 'Balance changes and refund status',
        icon: Icons.account_balance_wallet,
        type: NotificationCategoryType.financial,
        numOfNotifications: 1,
      ),
      NotificationCategoryModel(
        name: 'Updates',
        description: 'News, policies, and system announcements',
        icon: Icons.info,
        type: NotificationCategoryType.update,
        numOfNotifications: 5,
      ),
      NotificationCategoryModel(
        name: 'Awards',
        description: 'Sweepstakes and contest winning announcements',
        icon: Icons.emoji_events,
        type: NotificationCategoryType.award,
        numOfNotifications: 0,
      ),
    ];
  }

  /// Fixed seed list, newest first; order ids match `OrderMock.seed()` and
  /// the three newest are unread.
  static List<NotificationModel> generateMockNotifications({DateTime? now}) {
    final today = now ?? DateTime.now();
    const rows = <(int, NotificationType, String, String, String?)>[
      (
        35,
        NotificationType.orderUpdate,
        'Order placed',
        'We received order #TK100012 and will confirm it shortly.',
        'TK100012',
      ),
      (
        140,
        NotificationType.promotion,
        'Flash sale is live',
        'Up to 30% off scarves, bags and running gear until midnight.',
        null,
      ),
      (
        320,
        NotificationType.orderUpdate,
        'Packing your order',
        'Order #TK100011 is confirmed and being packed.',
        'TK100011',
      ),
      (
        60 * 20,
        NotificationType.orderUpdate,
        'Out for delivery',
        'Order #TK100010 is on its way. Keep your phone nearby.',
        'TK100010',
      ),
      (
        60 * 26,
        NotificationType.newProduct,
        'New arrivals just dropped',
        'Fresh dresses, knitwear and sneakers for the new season.',
        null,
      ),
      (
        60 * 30,
        NotificationType.orderUpdate,
        'Order shipped',
        'Order #TK100009 has left our warehouse.',
        'TK100009',
      ),
      (
        60 * 50,
        NotificationType.promotion,
        'Your voucher: TUKU10',
        'Take 10% off your next order. Enter TUKU10 at checkout.',
        null,
      ),
      (
        60 * 72,
        NotificationType.orderUpdate,
        'Delivered',
        'Order #TK100008 was delivered. Enjoy your new pieces!',
        'TK100008',
      ),
      (
        60 * 96,
        NotificationType.orderUpdate,
        'Order cancelled',
        'Order #TK100007 was cancelled. No payment was taken.',
        'TK100007',
      ),
      (
        60 * 120,
        NotificationType.promotion,
        'Free shipping weekend',
        'Use FREESHIP for free standard delivery on any order.',
        null,
      ),
      (
        60 * 168,
        NotificationType.account,
        'Profile updated',
        'Your delivery details were saved.',
        null,
      ),
      (
        60 * 240,
        NotificationType.general,
        'Welcome to Tuku Shop',
        'Save favorites, track orders and get member-only offers.',
        null,
      ),
    ];

    return [
      for (var i = 0; i < rows.length; i++)
        NotificationModel(
          id: 'N${i + 1}',
          title: rows[i].$3,
          body: rows[i].$4,
          timestamp: today.subtract(Duration(minutes: rows[i].$1)),
          isRead: i >= 3,
          type: rows[i].$2,
          relatedItemId: rows[i].$5,
        ),
    ];
  }
}
