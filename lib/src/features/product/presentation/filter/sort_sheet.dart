import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import '../widgets/product_labels.dart';

Future<void> showSortSheet(
  BuildContext context, {
  required ProductSort current,
  required ValueChanged<ProductSort> onSelected,
}) => showSdBottomSheetV5<void>(
  context: context,
  builder: (BuildContext sheetContext) => SdBottomSheetV5(
    title: sheetContext.loc.sort_title,
    closeTooltip: sheetContext.loc.action_close,
    child: Column(
      children: <Widget>[
        for (final ProductSort sort in ProductSort.values)
          SdListTileV5(
            title: sheetContext.sortLabel(sort),
            trailing: AnimatedOpacity(
              opacity: sort == current ? 1 : 0,
              duration: SdMotionV5.fast,
              child: SdIconV5(Symbols.check_rounded),
            ),
            onTap: () {
              Navigator.of(sheetContext).pop();
              onSelected(sort);
            },
          ),
      ],
    ),
  ),
);
