import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/models/place_location.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/utils/dimens.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends ConsumerState<NewPlaceScreen> {
  final _placeTitleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _placeTitleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    if (_placeTitleController.text.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) return;
    ref.read(placesProvider.notifier).addFavoritePlace(Place(
        title: _placeTitleController.text,
        image: _selectedImage!,
        location: _selectedLocation!));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimens.padding),
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              controller: _placeTitleController,
              decoration:
                  const InputDecoration(label: Text('Type a place name')),
            ),
            const SizedBox(height: Dimens.padding),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: Dimens.padding),
            LocationInput(
              onSelecteLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: Dimens.padding),
            ElevatedButton(
                onPressed: _savePlace, child: const Text('Save Place'))
          ],
        ),
      ),
    );
  }
}
