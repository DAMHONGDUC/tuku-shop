import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';
import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/category/presentation/categories_section/categories_section_controller.dart';
import 'package:tuku_shop/src/features/category/presentation/widgets/category_card.dart';

/// The Categories tab: every category as a color-coded card.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoriesController>()..getData(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final controller = context.read<CategoriesController>();
    const spacing = SdSpacingV5.s12;

    return ColoredBox(
      color: colors.pageDefault,
      child: SafeArea(
        bottom: false,
        child: RefreshWrapper(
          onRefresh: () async => controller.getData(),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                  SdSpacingV5.s16,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    context.loc.categories_title,
                    style: SdTextStyleV5.heading24().wColor(colors.textDefault),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  SdSpacingV5.s16,
                  0,
                  SdSpacingV5.s16,
                  FloatingBottomNav.contentInset(context),
                ),
                sliver: BlocBuilder<CategoriesController, CategoriesState>(
                  builder: (context, state) {
                    const delegate = SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: spacing,
                      crossAxisSpacing: spacing,
                      mainAxisExtent: 112,
                    );
                    if (state is CategoriesError) {
                      return SliverToBoxAdapter(
                        child: SectionError(onRetry: controller.getData),
                      );
                    }
                    if (state is CategoriesLoaded) {
                      return SliverGrid.builder(
                        gridDelegate: delegate,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) =>
                            CategoryGridCard(category: state.categories[index]),
                      );
                    }
                    return SliverGrid.builder(
                      gridDelegate: delegate,
                      itemCount: 8,
                      itemBuilder: (_, _) => const SkeletonBox(
                        height: 112,
                        radius: UIConstants.cardRadius,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
