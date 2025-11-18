import 'package:flutter/material.dart';
import 'package:pacil_station_mobile/models/product_entry.dart';
import 'package:pacil_station_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:pacil_station_mobile/screens/product_detail.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  bool showOnlyMyProducts = false;
  List<Product> allProducts = [];

  Future<List<Product>> fetchProducts(CookieRequest request) async {

    final response = await request.get(
      'https://heraldo-arman-pacilstation.pbp.cs.ui.ac.id/json/',
    );

    var data = response;

    allProducts.clear();
    for (var d in data) {
      if (d != null) {
        allProducts.add(Product.fromJson(d));
      }
    }

    return getFilteredProducts();
  }

  List<Product> getFilteredProducts() {
    if (showOnlyMyProducts) {
      List<Product> myProducts = allProducts
          .where((product) => product.fields.isMine)
          .toList();
      return myProducts;
    } else {
      return allProducts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(showOnlyMyProducts ? 'My Products' : 'All Products'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(
              showOnlyMyProducts ? Icons.person : Icons.people,
              color: showOnlyMyProducts ? Colors.blue : Colors.white,
            ),
            onPressed: () {
              setState(() {
                showOnlyMyProducts = !showOnlyMyProducts;
              });
            },
          ),

        ],
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: showOnlyMyProducts
                ? Colors.blue.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  showOnlyMyProducts ? Icons.person : Icons.people,
                  size: 20,
                  color: showOnlyMyProducts ? Colors.blue : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  showOnlyMyProducts
                      ? 'Showing only my products'
                      : 'Showing all products',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: showOnlyMyProducts ? Colors.blue : Colors.grey[600],
                  ),
                ),
                const Spacer(),
                if (showOnlyMyProducts)
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        showOnlyMyProducts = false;
                      });
                    },
                    icon: const Icon(Icons.clear, size: 16),
                    label: const Text('Show All'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: fetchProducts(request),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => setState(() {}),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  List<Product> displayedProducts = getFilteredProducts();

                  if (displayedProducts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            showOnlyMyProducts
                                ? Icons.person_off
                                : Icons.inventory_2_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            showOnlyMyProducts
                                ? 'You haven\'t added any products yet.'
                                : 'No products available.',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff59A5D8),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            showOnlyMyProducts
                                ? 'Start by adding your first product!'
                                : 'Check back later for new products.',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          if (showOnlyMyProducts) ...[
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/product-form',
                                ).then((_) => setState(() {}));
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Product'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          showOnlyMyProducts
                              ? 'You have ${displayedProducts.length} product${displayedProducts.length == 1 ? '' : 's'}'
                              : '${displayedProducts.length} product${displayedProducts.length == 1 ? '' : 's'} available',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: displayedProducts.length,
                          itemBuilder: (_, index) => ProductCard(
                            product: displayedProducts[index],
                            showOwnership: !showOnlyMyProducts,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    product: displayedProducts[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool showOwnership;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showOwnership = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.fields.thumbnail.isNotEmpty
                    ? Transform(
                        alignment: Alignment.center,
                        transform: product.fields.flipThumbnail
                            ? Matrix4.rotationY(3.14159)
                            : Matrix4.identity(),
                        child: Image.network(
                          'https://heraldo-arman-pacilstation.pbp.cs.ui.ac.id/proxy-image/?url=${Uri.encodeComponent(product.fields.thumbnail)}',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
              ),
              const SizedBox(width: 16),
  
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.fields.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (showOwnership && product.fields.isMine)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 12,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Mine',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blue[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${product.fields.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            product.fields.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (product.fields.isFeatured)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Featured',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.fields.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          ' ${product.fields.rating}/5',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Stock: ${product.fields.stock}',
                          style: TextStyle(
                            fontSize: 12,
                            color: product.fields.stock > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
