import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/utils/dimens.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/widgets/place_item.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() {
    return _PlacesState();
  }
}

class _PlacesState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFulture;

  @override
  void initState() {
    super.initState();
    _placesFulture = ref.read(placesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlaces = ref.watch(placesProvider);
    Widget emptyContent = const Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No places added yet.')]),
    );

    Widget content = favoritePlaces.isEmpty
        ? emptyContent
        : ListView.builder(
            itemCount: favoritePlaces.length,
            itemBuilder: (ctx, index) {
              return PlaceItem(place: favoritePlaces[index]);
            },
          );
    Widget loadingSpinner = const Center(child: CircularProgressIndicator());

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
        padding: const EdgeInsets.all(Dimens.padding),
        child: FutureBuilder(
            future: _placesFulture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? loadingSpinner
                    : content),
      ),
    );
  }
}
