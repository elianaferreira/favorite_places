import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.title),
      trailing:
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right)),
    );
  }
}
