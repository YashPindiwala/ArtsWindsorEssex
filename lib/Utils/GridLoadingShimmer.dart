import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridLoadingShimmer extends StatelessWidget {
  const GridLoadingShimmer({super.key});
  static const List<double> _heightContainer = [150,150,75,225,150,150,150,75,225,150];
  @override
  Widget build(BuildContext context) {

    return MasonryGridView.count(
      padding: EdgeInsets.only(bottom: 100),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      itemCount: _heightContainer.length,
      itemBuilder: (context, index) {
        return CardLoading(
            height: _heightContainer[index],
            borderRadius: BorderRadius.circular(25),
        );
      },
    );
  }
}
