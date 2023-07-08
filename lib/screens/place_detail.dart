import 'package:flutter/material.dart';

import 'package:favorite_places/utils/dimens.dart';
import 'package:favorite_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: Dimens.avatarBigSize,
                    backgroundImage: NetworkImage(place.location.locationImage),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.paddingBig,
                        vertical: Dimens.padding),
                    alignment: Alignment.center,
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
