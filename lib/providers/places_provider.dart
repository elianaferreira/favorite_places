import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

import 'package:favorite_places/models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier()
      : super(
            const []); // added const to ensure no no update the data mistakenly

  void addFavoritePlace(Place place) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(
        place.image.path); //get the filename of the temporary image file
    File copiedImage = await place.image.copy('${appDir.path}/$fileName');
    place.setImage(copiedImage);

    final placeWasSavedBefore = state.contains(place);
    if (!placeWasSavedBefore) state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
