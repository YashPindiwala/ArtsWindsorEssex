import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListViewShimmerHZ extends StatelessWidget {
  const ListViewShimmerHZ({super.key});
  @override
  Widget build(BuildContext context) {
    return CardLoading(
          height: MediaQuery.of(context).size.height*0.06,
          width: double.infinity,
          borderRadius: BorderRadius.circular(25),
        );
  }
}
