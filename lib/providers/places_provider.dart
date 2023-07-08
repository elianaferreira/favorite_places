import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier()
      : super(
            const []); // added const to ensure no make the mistake of update the data

  void addFavoritePlace(Place place) {
    final placeWasSavedBefore = state.contains(place);
    if (!placeWasSavedBefore) state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
