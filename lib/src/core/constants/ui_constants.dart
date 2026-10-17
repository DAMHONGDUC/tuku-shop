import 'package:system_design/index.dart';

class UIConstants {
  // banner
  static const bannerHeight = 168.0;
  static const bannerBorderRadius = SdSpacingV5.s16;
  static const bannerTagWidth = 80.0;

  // categories
  static const categoriesImageWidth = 64.0;
  static const categoriesImageHeight = 64.0;
  static const categoriesListHeight = 92.0;
  static const categoriesCardWidth = categoriesImageWidth + 12.0;

  // motion (cloned from the V3 floating bar timings)
  static const navFast = Duration(milliseconds: 150);
  static const navNormal = Duration(milliseconds: 250);

  // cards
  static const cardRadius = SdSpacingV5.s16;
  static const imageRadius = SdSpacingV5.s12;
  static const sheetRadius = SdSpacingV5.s24;
  static const productImageAspect = 4 / 5;
  static const productStripCardWidth = 156.0;

  // touch
  static const minTapTarget = SdSpacingV5.s44;

  // lists
  static const pageSize = 10;
  static const loadMoreThreshold = 300.0;
}
