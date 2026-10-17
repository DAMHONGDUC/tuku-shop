import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

import 'addresses_controller.dart';

/// The address book, from the profile.
class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<AddressesController>(
    create: (BuildContext _) => getIt<AddressesController>()..load(),
    child: BlocBuilder<AddressesController, AddressesState>(
      builder: (BuildContext context, AddressesState state) {
        final AddressesController controller = context
            .read<AddressesController>();

        Future<void> open([String? id]) async {
          await context.push<Object?>(
            AppRoutes.addressForm.path,
            extra: AddressFormArgs(addressId: id),
          );
          await controller.load();
        }

        return SdScaffoldV5(
          appBar: SdAppBarV5(title: context.loc.addresses_title),
          bottomBar: Padding(
            padding: EdgeInsets.fromLTRB(
              SdContentPaddingV5.horizontal,
              SdSpacingConstant.h8,
              SdContentPaddingV5.horizontal,
              SdContentPaddingV5.detailBottom(context),
            ),
            child: SdButtonV5(
              variant: SdButtonVariantV5.primary,
              label: context.loc.address_add,
              icon: Symbols.add_rounded,
              expand: true,
              onPressed: open,
            ),
          ),
          body: FadeSwitcher(
            child: switch (state.status) {
              LoadStatus.loading => const Center(child: SdLoadingV5()),
              LoadStatus.failure => ErrorView(onRetry: controller.load),
              LoadStatus.success when state.addresses.isEmpty => SdEmptyStateV5(
                icon: Symbols.location_off_rounded,
                title: context.loc.addresses_empty,
              ),
              LoadStatus.success => ListView.separated(
                padding: SdContentPaddingV5.gutter.copyWith(
                  top: SdSpacingConstant.h8,
                ),
                itemCount: state.addresses.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: SdContentPaddingV5.itemGap),
                itemBuilder: (BuildContext context, int i) {
                  final AddressEntity a = state.addresses[i];

                  return SdFadeInV5(
                    index: i,
                    child: SdCardV5(
                      borderColor: a.isDefault
                          ? context.sdTheme5.textPrimary
                          : null,
                      onTap: () => open(a.id),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SdIconV5(
                                a.label.toLowerCase() == 'office'
                                    ? Symbols.work_rounded
                                    : Symbols.home_rounded,
                              ),
                              SizedBox(width: SdSpacingConstant.w8),
                              Expanded(
                                child: Text(
                                  a.label,
                                  style: context.textTheme5.titleSmall,
                                ),
                              ),
                              if (a.isDefault)
                                SdBadgeV5(
                                  label: context.loc.address_default,
                                  tone: SdBadgeToneV5.inverse,
                                ),
                            ],
                          ),
                          SizedBox(height: SdSpacingConstant.h10),
                          Text(
                            '${a.fullName}  ·  ${a.phone}',
                            style: context.textTheme5.bodyMedium,
                          ),
                          SizedBox(height: SdSpacingConstant.h2),
                          Text(
                            a.oneLine,
                            style: context.textTheme5.bodySmall!.muted5(
                              context,
                            ),
                          ),
                          SizedBox(height: SdSpacingConstant.h8),
                          Row(
                            children: <Widget>[
                              if (!a.isDefault)
                                SdButtonV5(
                                  variant: SdButtonVariantV5.text,
                                  size: SdButtonSizeV5.small,
                                  label: context.loc.address_make_default,
                                  onPressed: () => controller.makeDefault(a),
                                ),
                              const Spacer(),
                              SdIconButtonV5(
                                icon: Symbols.delete_rounded,
                                tooltip: context.loc.action_remove,
                                size: SdSpacingConstant.r36,
                                color: context.sdTheme5.danger,
                                onPressed: () => showSdDialogV5<void>(
                                  context,
                                  SdDialogV5(
                                    icon: Symbols.delete_rounded,
                                    iconColor: context.sdTheme5.danger,
                                    title: context.loc.address_delete_title,
                                    message: a.oneLine,
                                    actions: <SdDialogActionV5>[
                                      SdDialogActionV5(
                                        label: context.loc.action_remove,
                                        variant: SdButtonVariantV5.destructive,
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop();
                                          controller.delete(a.id);
                                        },
                                      ),
                                      SdDialogActionV5(
                                        label: context.loc.action_cancel,
                                        onPressed: () => Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            },
          ),
        );
      },
    ),
  );
}
