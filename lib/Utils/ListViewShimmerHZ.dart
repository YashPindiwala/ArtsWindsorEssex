import 'package:flutter/material.dart'; // Importing material package
import 'package:card_loading/card_loading.dart'; // Importing card_loading package
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Importing flutter_staggered_grid_view package

class ListViewShimmerHZ extends StatelessWidget {
  const ListViewShimmerHZ({Key? key});

  @override
  Widget build(BuildContext context) {
    return CardLoading(
      // Displaying a shimmer effect using CardLoading widget
      height: MediaQuery.of(context).size.height *
          0.06, // Setting the height based on device screen height
      width: double.infinity, // Setting the width to fill the available space
      borderRadius: BorderRadius.circular(
          25), // Setting border radius for the shimmer effect
    );
  }
}
