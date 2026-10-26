import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/address/domain/domain.dart';

import 'address_book_controller.dart';

/// Saved addresses. In pick mode a tap returns that address's id.
class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({super.key, this.pickMode = false, this.selectedId});

  final bool pickMode;
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressBookController>()..load(),
      child: _View(pickMode: pickMode, selectedId: selectedId),
    );
  }
}

class _View extends StatelessWidget {
  const _View({required this.pickMode, this.selectedId});

  final bool pickMode;
  final String? selectedId;

  Future<void> _openForm(BuildContext context, [AddressEntity? address]) async {
    final saved = await context.push<bool>(
      AddressRoutes.addressForm.fullPath,
      extra: address,
    );
    if (saved == true && context.mounted) {
      context.read<AddressBookController>().load(silent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Scaffold(
      backgroundColor: colors.pageDefault,
      appBar: AppTopBar(
        title: pickMode
            ? context.loc.address_pick_title
            : context.loc.address_book_title,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add),
        label: Text(context.loc.address_add),
      ),
      body: BlocBuilder<AddressBookController, AddressBookState>(
        builder: (context, state) {
          final controller = context.read<AddressBookController>();
          return switch (state.status) {
            AddressBookStatus.loading => ListView(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              children: [
                for (var i = 0; i < 2; i++) ...[
                  const SkeletonBox(
                    height: 120,
                    radius: UIConstants.cardRadius,
                  ),
                  SdVerticalSpacingV5(value: SdSpacingV5.s12),
                ],
              ],
            ),
            AddressBookStatus.error => Padding(
              padding: EdgeInsets.all(SdSpacingV5.s16),
              child: SectionError(onRetry: controller.load),
            ),
            AddressBookStatus.loaded when state.addresses.isEmpty => Center(
              child: EmptyState(
                icon: Icons.location_on_outlined,
                title: context.loc.address_empty_title,
                message: context.loc.address_empty_message,
                actionLabel: context.loc.address_add,
                onAction: () => _openForm(context),
              ),
            ),
            AddressBookStatus.loaded => ListView.separated(
              padding: EdgeInsets.fromLTRB(
                SdSpacingV5.s16,
                SdSpacingV5.s8,
                SdSpacingV5.s16,
                96,
              ),
              itemCount: state.addresses.length,
              separatorBuilder: (_, _) =>
                  SdVerticalSpacingV5(value: SdSpacingV5.s12),
              itemBuilder: (context, index) {
                final address = state.addresses[index];
                return AddressCard(
                  address: address,
                  selected: pickMode && address.id == selectedId,
                  onTap: pickMode
                      ? () => context.pop(address.id)
                      : () => _openForm(context, address),
                  trailing: pickMode
                      ? IconButton(
                          icon: Icon(
                            Icons.edit_outlined,
                            color: colors.iconSecondary,
                          ),
                          onPressed: () => _openForm(context, address),
                        )
                      : PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: colors.iconSecondary,
                          ),
                          onSelected: (action) => action == 'default'
                              ? controller.setDefault(address.id)
                              : controller.delete(address.id),
                          itemBuilder: (_) => [
                            if (!address.isDefault)
                              PopupMenuItem(
                                value: 'default',
                                child: Text(context.loc.address_set_default),
                              ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(context.loc.address_delete),
                            ),
                          ],
                        ),
                );
              },
            ),
          };
        },
      ),
    );
  }
}

/// One address: label chip, default badge, name, phone and the address.
class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    this.onTap,
    this.selected = false,
    this.trailing,
  });

  final AddressEntity address;
  final VoidCallback? onTap;
  final bool selected;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Material(
      color: colors.cardDefault,
      borderRadius: BorderRadius.circular(UIConstants.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(UIConstants.cardRadius),
        child: Container(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstants.cardRadius),
            border: Border.all(
              color: selected ? colors.primary : colors.borderDefault,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TagChip(
                          label: address.label,
                          color: colors.textSubTitle,
                        ),
                        if (address.isDefault) ...[
                          SdHorizontalSpacingV5(value: SdSpacingV5.s8),
                          TagChip(
                            label: context.loc.address_default,
                            color: colors.primary,
                          ),
                        ],
                      ],
                    ),
                    SdVerticalSpacingV5(value: SdSpacingV5.s8),
                    Text(
                      '${address.fullName} · ${address.phone}',
                      style: SdTextStyleV5.body14().wSemiBold().wColor(
                        colors.textDefault,
                      ),
                    ),
                    SdVerticalSpacingV5(value: SdSpacingV5.s4),
                    Text(
                      address.singleLine,
                      style: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                    ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
