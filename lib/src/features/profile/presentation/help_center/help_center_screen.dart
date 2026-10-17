import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';

import 'components/faq_tile.dart';

/// Frequently asked questions and the ways to reach support. Contact is a
/// demo: every channel answers with a snackbar.
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> faqs = <(String, String)>[
      (context.loc.help_q_shipping, context.loc.help_a_shipping),
      (context.loc.help_q_returns, context.loc.help_a_returns),
      (context.loc.help_q_track, context.loc.help_a_track),
      (context.loc.help_q_cancel, context.loc.help_a_cancel),
      (context.loc.help_q_promo, context.loc.help_a_promo),
      (context.loc.help_q_points, context.loc.help_a_points),
    ];

    void contact() =>
        SdSnackBarUtilsV5.info(context, context.loc.help_contact_demo);

    final List<Widget> children = <Widget>[
      SdSectionHeaderV5(title: context.loc.help_faq),
      for (final (String question, String answer) in faqs) ...<Widget>[
        FaqTile(question: question, answer: answer),
        SizedBox(height: SdSpacingConstant.h8),
      ],
      SizedBox(height: SdContentPaddingV5.sectionGap - SdSpacingConstant.h8),
      SdSectionHeaderV5(title: context.loc.help_contact),
      SdListTileV5(
        icon: Symbols.chat_rounded,
        title: context.loc.help_chat,
        subtitle: context.loc.help_chat_hint,
        onTap: contact,
      ),
      SdListTileV5(
        icon: Symbols.mail_rounded,
        title: context.loc.help_email,
        subtitle: context.loc.help_email_hint,
        onTap: contact,
      ),
      SdListTileV5(
        icon: Symbols.call_rounded,
        title: context.loc.help_call,
        subtitle: context.loc.help_call_hint,
        onTap: contact,
      ),
    ];

    return SdScaffoldV5(
      appBar: SdAppBarV5(title: context.loc.help_title),
      body: ListView(
        padding: SdContentPaddingV5.gutter.copyWith(
          top: SdSpacingConstant.h8,
          bottom: SdContentPaddingV5.detailBottom(context),
        ),
        children: <Widget>[
          for (final (int i, Widget child) in children.indexed)
            SdFadeInV5(index: i, child: child),
        ],
      ),
    );
  }
}
