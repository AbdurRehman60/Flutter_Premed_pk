import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/export.dart';

class CustomTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return TabBar(
      indicatorColor: PreMedColorTheme().white,
      tabs: [
        Tab(
          child: Text(
            'Solved Questions',
            style: PreMedTextTheme()
                .subtext
                .copyWith(color: PreMedColorTheme().white),
          ),
        ),
        Tab(
          child: Text(
            'Pending Questions',
            style: PreMedTextTheme()
                .subtext
                .copyWith(color: PreMedColorTheme().white),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => throw UnimplementedError();

  @override
  // TODO: implement minExtent
  double get minExtent => throw UnimplementedError();

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
