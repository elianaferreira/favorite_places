import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favorite_places/models/place.dart';

const tableName = 'user_places';

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

    final dbPath =
        await sql.getDatabasesPath(); //yiels the directory of the database
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng, REAL, address TEXT)');
      },
      version: 1,
    ); //open an existing DB or create it

    db.insert(tableName, place.mapToSaveInDB);

    final placeWasSavedBefore = state.contains(place);
    if (!placeWasSavedBefore) state = [...state, place];
  }
}

final placesProvider = StateNotifierProvider<PlacesNotifier, List<Place>>(
    (ref) => PlacesNotifier());
