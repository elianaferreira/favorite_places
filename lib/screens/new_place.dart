import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends ConsumerState<NewPlaceScreen> {
  final _placeTitleController = TextEditingController();

  @override
  void dispose() {
    _placeTitleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    ref
        .read(placesProvider.notifier)
        .addFavoritPlace(Place(title: _placeTitleController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Place')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              controller: _placeTitleController,
              decoration:
                  const InputDecoration(label: Text('Type a place name')),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _savePlace, child: const Text('Save Place'))
          ],
        ),
      ),
    );
  }
}
