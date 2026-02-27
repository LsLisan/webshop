import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<dynamic> products;
  final bool isLoading;
  final String category;

  const ProductGrid({
    super.key,
    required this.products,
    required this.isLoading,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return Builder(
      builder: (context) {
        // Each tab supplies its own CustomScrollView; the actual vertical
        // motion is forwarded to the parent NestedScrollView via the
        // overlap mechanism. A PageStorageKey is used so that when the user
        // returns to a tab, its inner scroll offset is restored. This avoids
        // jumping back to the top but does not break the "single owner" rule
        // since the outer NestedScrollView still governs the physical
        // scrolling.
        return CustomScrollView(
          key: PageStorageKey(category), // Preserves scroll position per tab
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _ProductCard(product: products[index]),
                  childCount: products.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final dynamic product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.network(product['image'], fit: BoxFit.contain),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              "\$${product['price']}",
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
