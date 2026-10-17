import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/features/checkout/domain/domain.dart';

Future<void> showAddressPicker(
  BuildContext context, {
  required List<AddressEntity> addresses,
  required String? selectedId,
  required ValueChanged<String> onSelected,
  required VoidCallback onAdd,
}) => showSdBottomSheetV5<void>(
  context: context,
  builder: (BuildContext sheet) => SdBottomSheetV5(
    title: sheet.loc.checkout_address,
    closeTooltip: sheet.loc.action_close,
    footer: SdButtonV5(
      variant: SdButtonVariantV5.outlined,
      label: sheet.loc.address_add,
      icon: Symbols.add_rounded,
      expand: true,
      onPressed: () {
        Navigator.of(sheet).pop();
        onAdd();
      },
    ),
    child: Column(
      children: <Widget>[
        for (final AddressEntity a in addresses)
          Padding(
            padding: EdgeInsets.only(bottom: SdSpacingConstant.h10),
            child: SdSelectableCardV5(
              title: '${a.label} · ${a.fullName}',
              subtitle: a.oneLine,
              icon: Symbols.location_on_rounded,
              selected: a.id == selectedId,
              onSelected: () {
                Navigator.of(sheet).pop();
                onSelected(a.id);
              },
            ),
          ),
      ],
    ),
  ),
);
