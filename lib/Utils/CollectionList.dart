import 'package:flutter/material.dart';
import 'package:artswindsoressex/Utils/CollectionCard.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({super.key});

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, DetailScreen.id);
            },
            child: CollectionCard(),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: 5);
  }
}
