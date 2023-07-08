import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:favorite_places/models/place_location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(37.422, -122.084, ''),
      this.isSelecting = true});

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapState();
  }
}

class _MapState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final LatLng latLng =
        LatLng(widget.location.latitude, widget.location.longitude);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your location' : 'Your location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () {
                  //save and return to the previous screen
                },
                icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 16,
        ),
        markers: {Marker(markerId: const MarkerId('m1'), position: latLng)},
      ),
    );
  }
}
