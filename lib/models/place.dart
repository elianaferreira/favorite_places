import 'dart:io';

import 'package:uuid/uuid.dart';

import 'package:favorite_places/models/place_location.dart';

class Place {
  Place(
      {required this.title,
      required this.image,
      required this.location,
      String? id})
      : id = id ?? const Uuid().v4();

  final String id;
  final String title;
  File image;
  final PlaceLocation location;

  void setImage(File image) {
    this.image = image;
  }

  Map<String, Object> get mapToSaveInDB {
    return {
      'id': id,
      'title': title,
      'image': image.path,
      'lat': location.latitude,
      'lng': location.longitude,
      'address': location.address
    };
  }

  static Place getDecodedPlace(Map<String, Object?> encodedMap) {
    return Place(
        id: encodedMap['id'] as String,
        title: encodedMap['title'] as String,
        image: File(encodedMap['image'] as String),
        location: PlaceLocation(encodedMap['lat'] as double,
            encodedMap['lng'] as double, encodedMap['address'] as String));
  }
}
