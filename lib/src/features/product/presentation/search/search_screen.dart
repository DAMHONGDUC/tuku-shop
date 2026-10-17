import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';

import '../browse/product_browse_controller.dart';
import '../browse/product_browse_view.dart';
import 'search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: <BlocProvider<dynamic>>[
      BlocProvider<ProductSearchController>(
        create: (BuildContext _) => getIt<ProductSearchController>()..load(),
      ),
      BlocProvider<ProductBrowseController>(
        create: (BuildContext _) => getIt<ProductBrowseController>(),
      ),
    ],
    child: const _SearchView(),
  );
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _field = TextEditingController();
  Timer? _debounce;
  bool _started = false;

  static const Duration _debounceTime = Duration(milliseconds: 350);

  @override
  void dispose() {
    _debounce?.cancel();
    _field.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    context.read<ProductSearchController>().setKeyword(value);
    _debounce?.cancel();

    if (value.trim().isEmpty) return;

    _debounce = Timer(_debounceTime, () => _search(value, remember: false));
  }

  void _search(String value, {bool remember = true}) {
    final ProductBrowseController browse = context
        .read<ProductBrowseController>();

    if (!_started) {
      _started = true;
      browse.init(ProductQuery(keyword: value.trim()));
    } else {
      browse.setKeyword(value);
    }

    if (remember) context.read<ProductSearchController>().remember(value);
  }

  void _pick(String term) {
    _field.text = term;
    _field.selection = TextSelection.collapsed(offset: term.length);
    context.read<ProductSearchController>().setKeyword(term);
    FocusManager.instance.primaryFocus?.unfocus();
    _search(term);
  }

  @override
  Widget build(BuildContext context) => SdScaffoldV5(
    appBar: SdAppBarV5(
      titleWidget: Padding(
        padding: EdgeInsets.only(right: SdSpacingConstant.w8),
        child: SdSearchFieldV5(
          hint: context.loc.search_hint,
          controller: _field,
          clearTooltip: context.loc.search_clear,
          autofocus: true,
          onChanged: _onChanged,
          onSubmitted: (String v) => _search(v),
        ),
      ),
      centerTitle: false,
    ),
    body: BlocBuilder<ProductSearchController, ProductSearchState>(
      builder: (BuildContext context, ProductSearchState state) => FadeSwitcher(
        child: state.showSuggestions
            ? _Suggestions(state: state, onPick: _pick)
            : BrowseScrollListener(
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: <Widget>[
                    ProductBrowseSlivers(
                      heroPrefix: 'search',
                      bottomInset: SdContentPaddingV5.detailBottom(context),
                    ),
                  ],
                ),
              ),
      ),
    ),
  );
}

class _Suggestions extends StatelessWidget {
  const _Suggestions({required this.state, required this.onPick});

  final ProductSearchState state;
  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) => ListView(
    padding: SdContentPaddingV5.gutter.copyWith(top: SdSpacingConstant.h12),
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    children: <Widget>[
      if (state.recent.isNotEmpty) ...<Widget>[
        SdSectionHeaderV5(
          title: context.loc.search_recent,
          actionLabel: context.loc.search_clear_recent,
          onAction: context.read<ProductSearchController>().clearRecent,
        ),
        SizedBox(height: SdSpacingConstant.h12),
        Wrap(
          spacing: SdSpacingConstant.w8,
          runSpacing: SdSpacingConstant.h8,
          children: <Widget>[
            for (final (int i, String term) in state.recent.indexed)
              SdFadeInV5(
                index: i,
                child: SdChipV5(
                  label: term,
                  icon: Symbols.history_rounded,
                  selected: false,
                  onSelected: () => onPick(term),
                ),
              ),
          ],
        ),
        SizedBox(height: SdContentPaddingV5.sectionGap),
      ],
      SdSectionHeaderV5(title: context.loc.search_trending),
      SizedBox(height: SdSpacingConstant.h4),
      for (final (int i, String term) in state.trending.indexed)
        SdFadeInV5(
          index: i,
          child: SdListTileV5(
            title: term,
            icon: Symbols.trending_up_rounded,
            onTap: () => onPick(term),
          ),
        ),
    ],
  );
}
