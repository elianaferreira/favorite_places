import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/place_item.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(placesProvider);
    Widget emptyContent = const Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No places added yet.')]),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NewPlaceScreen(),
                  ));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: favoritePlaces.isEmpty
              ? emptyContent
              : ListView.builder(
                  itemCount: favoritePlaces.length,
                  itemBuilder: (ctx, index) {
                    return PlaceItem(place: favoritePlaces[index]);
                  },
                ),
        ));
  }
}
