import 'package:tuku_shop/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart' hide SdContextV2X;

class BottomTabBaseScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomTabBaseScreen({super.key, required this.navigationShell});

  Widget _buildIcon({
    required bool isSelected,
    IconData? iconSelected,
    IconData? icon,
    String? imgPath,
    String? imgPathSelected,
  }) {
    final isValid =
        (icon != null && iconSelected != null) ||
        (imgPath != null && imgPathSelected != null);

    if (isValid) {
      return SdIconV5(
        iconData: isSelected ? iconSelected : icon,
        iconPath: isSelected ? imgPathSelected : imgPath,
        color: isSelected ? AppColors.primary : AppColors.grey,
        iconSize: SdSpacingV5.s20,
      );
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final iconPadding = EdgeInsets.only(
      top: SdSpacingV5.s4,
      bottom: SdSpacingV5.s4,
    );

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onItemTapped(context, index),
        selectedLabelStyle: context.textTheme.heading12,
        unselectedLabelStyle: context.textTheme.body12.copyWith(
          color: AppColors.grey,
        ),
        backgroundColor: context.colorTheme.surfaceDefault,
        elevation: 0.5,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        iconSize: SdSpacingV5.s18,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: iconPadding,
              child: _buildIcon(
                isSelected: navigationShell.currentIndex == 0,
                imgPath: '${kAssetsIconPath}ic_home.svg',
                imgPathSelected: '${kAssetsIconPath}ic_home_selected.svg',
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: iconPadding,
              child: _buildIcon(
                isSelected: navigationShell.currentIndex == 1,
                icon: Icons.local_shipping_outlined,
                iconSelected: Icons.local_shipping,
              ),
            ),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: iconPadding,
              child: _buildIcon(
                isSelected: navigationShell.currentIndex == 2,
                icon: Icons.notifications_outlined,
                iconSelected: Icons.notifications,
              ),
            ),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: iconPadding,
              child: _buildIcon(
                isSelected: navigationShell.currentIndex == 3,
                icon: Icons.person_outline,
                iconSelected: Icons.person,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
