import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';

class CardLoadingShimmer extends StatelessWidget {
  const CardLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CardLoading(
                      height: 30,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      width: 200,
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    CardLoading(
                      height: 100,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardLoading(
                          height: 30,
                          width: 100,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        CardLoading(
                          height: 30,
                          width: 70,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
