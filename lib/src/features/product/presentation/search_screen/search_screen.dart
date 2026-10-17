import 'package:tuku_shop/src/core/core.dart';
import 'package:tuku_shop/src/di/injector.dart';
import 'package:tuku_shop/src/features/product/presentation/product_detail/product_detail_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_design/index.dart';

import 'search_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchProductsController>(),
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    context.read<SearchProductsController>().search(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Products')),
      body: Padding(
        padding: EdgeInsets.all(SdSpacingV5.s16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onQueryChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _onQueryChanged,
              onSubmitted: _onQueryChanged,
            ),
            SdVerticalSpacingV5(),
            Expanded(
              child: BlocBuilder<SearchProductsController, SearchProductsState>(
                builder: (context, state) {
                  if (state is SearchProductsInitial) {
                    return const Center(
                      child: Text('Start typing to search for products.'),
                    );
                  } else if (state is SearchProductsLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchProductsErrorState) {
                    return EmptyView(message: state.errorMsg);
                  } else if (state is SearchProductsLoadedState) {
                    if (state.products.isEmpty) {
                      return const EmptyView(message: 'No results found.');
                    }
                    return ListView.separated(
                      itemCount: state.products.length,
                      separatorBuilder: (_, __) =>
                          SdVerticalSpacingV5(value: SdSpacingV5.s8),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return Card(
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(product.name),
                            subtitle: Text(
                              SdCurrencyFormatHelperV5.formatPrice(
                                product.price,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              GoRouter.of(context).push(
                                ProductRoutes.productDetail.fullPath,
                                extra: ProductDetailArgs(productId: product.id),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
