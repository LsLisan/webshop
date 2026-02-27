import 'package:flutter/material.dart';

class StickyTabBar extends StatelessWidget {
  final TabController tabController;
  const StickyTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        TabBar(
          controller: tabController,
          labelColor: const Color(0xFFf36d21),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFf36d21),
          tabs: const [Tab(text: "All"), Tab(text: "Electronics"), Tab(text: "Jewelry")],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override double get minExtent => _tabBar.preferredSize.height;
  @override double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}