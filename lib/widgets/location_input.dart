import 'dart:convert';

import 'package:favorite_places/models/place_location.dart';
import 'package:favorite_places/widgets/border_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

final googleApiKey = dotenv.env['GOOGLE_API_KEY'];

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  bool _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) return '';
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${_pickedLocation!.latitude},${_pickedLocation!.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C${_pickedLocation!.latitude},${_pickedLocation!.longitude}&key=$googleApiKey';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    if (lat == null || lng == null) return;
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=$googleApiKey');
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final address = responseData['results'][0]
        ['formatted_address']; //based on the Geococing API documentation
    setState(() {
      _isGettingLocation = false;
      _pickedLocation = PlaceLocation(lat, lng, address);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = const Text(
      'No location chosen',
      textAlign: TextAlign.center,
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: borderDecoration(context),
          height: 170,
          width: double.infinity,
          child: previewContent,
        ), //map snapshot,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get current location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('Select on Map')),
          ],
        )
      ],
    );
  }
}
