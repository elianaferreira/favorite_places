import 'package:favorite_places/utils/constants.dart';

class PlaceLocation {
  PlaceLocation(this.latitude, this.longitude, this.address);

  final double latitude;
  final double longitude;
  final String address;

  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${latitude},${longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C${latitude},${longitude}&key=${Constants.googleApiKey}';
  }
}
