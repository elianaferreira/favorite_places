import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(place.title),
      subtitle: Text(place.location.address),
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: FileImage(place.image),
      ),
      trailing: const Icon(Icons.arrow_right),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlaceDetailScreen(place: place),
      )),
    );
  }
}
