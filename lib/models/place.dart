import 'dart:io';

import 'package:uuid/uuid.dart';

import 'package:favorite_places/models/place_location.dart';

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
  }) : id = const Uuid().v4();

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
}
