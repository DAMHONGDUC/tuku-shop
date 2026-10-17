import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/notification/data/models/notification_model.dart';

abstract final class NotificationMock {
  static const String _p = 'assets/images/product/';

  static List<NotificationModel> seed(DateTime now) => <NotificationModel>[
    NotificationModel(
      id: 'n1',
      type: 'order',
      title: 'Your order is on its way',
      body:
          'TK-261031 has left our fulfilment centre. Track it live from My Orders.',
      createdAt: now.subtract(const Duration(minutes: 25)),
      isRead: false,
      image: '${_p}mj01_orange_0.webp',
      link: '/orders/o_1031',
    ),
    NotificationModel(
      id: 'n2',
      type: 'promotion',
      title: 'Flash sale: up to 40% off',
      body:
          'Our biggest markdowns of the season end tonight. Your favourites are in it.',
      createdAt: now.subtract(const Duration(hours: 3)),
      isRead: false,
      image: AppAssets.bannerSale,
      link: '/products?title=Sale&sale=1',
    ),
    NotificationModel(
      id: 'n3',
      type: 'order',
      title: 'Out for delivery',
      body: 'TK-261027 will arrive today between 2pm and 6pm.',
      createdAt: now.subtract(const Duration(hours: 6)),
      isRead: false,
      image: '${_p}wb01_purple_0.webp',
      link: '/orders/o_1027',
    ),
    NotificationModel(
      id: 'n4',
      type: 'newArrival',
      title: 'Just landed: Autumn Essentials',
      body:
          'Soft fleece, warm layers and new colourways in hoodies and jackets.',
      createdAt: now.subtract(const Duration(days: 1, hours: 2)),
      isRead: true,
      image: AppAssets.bannerNew,
      link: '/products?title=New%20arrivals&new=1&sort=newest',
    ),
    NotificationModel(
      id: 'n5',
      type: 'account',
      title: 'You earned 120 points',
      body:
          'Thanks for your last order. You are 520 points away from Gold status.',
      createdAt: now.subtract(const Duration(days: 2)),
      isRead: true,
    ),
    NotificationModel(
      id: 'n6',
      type: 'promotion',
      title: 'A little something for you',
      body: 'Use code TUKU10 for 10% off your next order.',
      createdAt: now.subtract(const Duration(days: 4)),
      isRead: true,
      image: AppAssets.bannerWomen,
    ),
    NotificationModel(
      id: 'n7',
      type: 'order',
      title: 'Delivered',
      body: 'TK-260996 was delivered. How does it fit? Leave a review.',
      createdAt: now.subtract(const Duration(days: 17)),
      isRead: true,
      image: '${_p}mh03_black_0.webp',
      link: '/orders/o_0996',
    ),
  ];
}
