import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'widgets/shop_header.dart';
import 'widgets/sticky_tab_bar.dart';
import 'widgets/product_grid.dart';

class WebShopScreen extends StatefulWidget {
  const WebShopScreen({super.key});

  @override
  State<WebShopScreen> createState() => _WebShopScreenState();
}

class _WebShopScreenState extends State<WebShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isLoading = true;
  List<dynamic> _products = [];
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    try {
      final res = await Future.wait([
        http.get(Uri.parse('https://fakestoreapi.com/products')),
        http.get(Uri.parse('https://fakestoreapi.com/users/1')),
      ]);
      setState(() {
        _products = json.decode(res[0].body);
        _user = json.decode(res[1].body);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Fetch Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        onRefresh: _fetchData,
        backgroundColor: Colors.white,
        color: Colors.orange,
        springAnimationDurationInMilliseconds: 500,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              // Ownership: Outer Scroll
              ShopHeader(user: _user),
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: StickyTabBar(tabController: _tabController),
              ),
            ];
          },

          body: TabBarView(
            controller: _tabController,
            children: [
              ProductGrid(
                products: _products,
                isLoading: _isLoading,
                category: "All",
              ),
              ProductGrid(
                products: _products
                    .where((p) => p['category'] == "electronics")
                    .toList(),
                isLoading: _isLoading,
                category: "Electronics",
              ),
              ProductGrid(
                products: _products
                    .where((p) => p['category'] == "jewelery")
                    .toList(),
                isLoading: _isLoading,
                category: "Jewelry",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
