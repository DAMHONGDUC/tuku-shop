import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/domain/domain.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_grid_section.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_list_controller.dart';
import 'package:tuku_shop/src/features/product/presentation/product_list/product_strip_section.dart';

import 'search_suggestions_controller.dart';

/// Search that is never blank: recent, trending and recommended items
/// before typing, live paged results after.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SearchSuggestionsController>()..load(),
        ),
        BlocProvider(create: (_) => getIt<ProductListController>()),
      ],
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _search(String keyword, {bool save = false}) {
    context.read<ProductListController>().search(keyword);
    if (save) context.read<SearchSuggestionsController>().save(keyword);
    setState(() {});
  }

  void _useSuggestion(String keyword) {
    _textController.text = keyword;
    _textController.selection = TextSelection.collapsed(offset: keyword.length);
    FocusScope.of(context).unfocus();
    _search(keyword, save: true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final hasQuery = _textController.text.trim().isNotEmpty;
    final results = context.read<ProductListController>();

    return SdKeyboardDismisserV5(
      child: Scaffold(
        backgroundColor: colors.pageDefault,
        appBar: AppBar(
          backgroundColor: colors.pageDefault,
          surfaceTintColor: SdColorsV5.transparent,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(right: SdSpacingV5.s16),
            child: TextField(
              controller: _textController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: _search,
              onSubmitted: (value) => _search(value, save: true),
              style: SdTextStyleV5.body14().wColor(colors.textDefault),
              decoration: InputDecoration(
                hintText: context.loc.search_hint,
                hintStyle: SdTextStyleV5.body14().wColor(colors.textSubTitle),
                filled: true,
                fillColor: colors.cardDefault,
                isDense: true,
                prefixIcon: Icon(Icons.search, color: colors.iconSecondary),
                suffixIcon: hasQuery
                    ? IconButton(
                        icon: Icon(Icons.close, color: colors.iconSecondary),
                        onPressed: () {
                          _textController.clear();
                          _search('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                  borderSide: BorderSide(color: colors.borderDefault),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                  borderSide: BorderSide(color: colors.borderDefault),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SdSpacingV5.s12),
                  borderSide: BorderSide(color: colors.primary),
                ),
              ),
            ),
          ),
        ),
        body: hasQuery
            ? LoadMoreListener(
                onLoadMore: results.loadMore,
                child: ListView(
                  padding: EdgeInsets.all(SdSpacingV5.s16),
                  children: [
                    ProductGridSection(
                      emptyTitle: context.loc.search_no_results_title,
                      emptyMessage: context.loc.search_no_results_message,
                    ),
                  ],
                ),
              )
            : _Suggestions(onPick: _useSuggestion),
      ),
    );
  }
}

class _Suggestions extends StatelessWidget {
  const _Suggestions({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final headingStyle = SdTextStyleV5.heading16().wColor(colors.textDefault);

    return BlocBuilder<SearchSuggestionsController, SearchSuggestionsState>(
      builder: (context, state) {
        return ListView(
          padding: EdgeInsets.all(SdSpacingV5.s16),
          children: [
            if (state.recent.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.loc.search_recent, style: headingStyle),
                  TextButton(
                    onPressed: () => context
                        .read<SearchSuggestionsController>()
                        .clearRecent(),
                    child: Text(
                      context.loc.search_clear,
                      style: SdTextStyleV5.body12().wColor(colors.textSubTitle),
                    ),
                  ),
                ],
              ),
              _ChipWrap(items: state.recent, onPick: onPick),
              SdVerticalSpacingV5(value: SdSpacingV5.s24),
            ],
            Text(context.loc.search_trending, style: headingStyle),
            SdVerticalSpacingV5(value: SdSpacingV5.s12),
            if (state.isLoading)
              const SkeletonBox(height: SdSpacingV5.s36, width: 240)
            else
              _ChipWrap(
                items: state.trending,
                onPick: onPick,
                icon: Icons.trending_up_rounded,
              ),
            SdVerticalSpacingV5(value: SdSpacingV5.s24),
            Text(context.loc.search_recommended, style: headingStyle),
            SdVerticalSpacingV5(value: SdSpacingV5.s12),
            BlocProvider(
              create: (_) => getIt<ProductListController>()
                ..load(
                  const ProductQuery(tag: ProductTag.bestSeller, pageSize: 8),
                ),
              child: const ProductStripSection(),
            ),
          ],
        );
      },
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.items, required this.onPick, this.icon});

  final List<String> items;
  final ValueChanged<String> onPick;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SdSpacingV5.s8,
      runSpacing: SdSpacingV5.s8,
      children: [
        for (final item in items)
          AppChip(label: item, icon: icon, onTap: () => onPick(item)),
      ],
    );
  }
}
