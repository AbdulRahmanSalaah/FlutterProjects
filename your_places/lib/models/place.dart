import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;

  final File image;

  final PlaceLocation location;

  // final Image staticMapImage;

// this.location,
  Place({
    // id is optional because it is generated by the uuid package if it is not provided
    String? id,
    required this.title,
    required this.image,
    required this.location,
    // required this.staticMapImage,
  }) : id = id ?? uuid.v4();
}