import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/auth/domain/domain.dart';

/// Avatar, name, email and join date, with the way into Edit profile.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, required this.onEdit, super.key});

  final UserEntity user;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) => SdCardV5(
    onTap: onEdit,
    semanticLabel: context.loc.edit_profile_title,
    child: Row(
      children: <Widget>[
        SdAvatarV5(
          initials: user.initials,
          image: user.avatar == null ? null : AssetImage(user.avatar!),
          size: SdSpacingConstant.r64,
        ),
        SizedBox(width: SdSpacingConstant.w16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user.fullName,
                style: context.textTheme5.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SdSpacingConstant.h2),
              Text(
                user.email,
                style: context.textTheme5.bodyMedium!.muted5(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SdSpacingConstant.h4),
              Text(
                context.loc.profile_member_since(
                  Formatters.date(user.memberSince, context.localeName),
                ),
                style: context.textTheme5.bodySmall!.muted5(context),
              ),
            ],
          ),
        ),
        SdIconV5(
          Symbols.edit_rounded,
          color: context.sdTheme5.textSecondary,
          semanticLabel: context.loc.edit_profile_title,
        ),
      ],
    ),
  );
}
