import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;

import 'package:your_places/models/place.dart';

Future<sql.Database> _getdatabase() async {
  final dppath = await sql.getDatabasesPath();
  final dp = await sql.openDatabase(
    path.join(
      dppath,
      'places.db',
    ),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
      );
    },
    version: 1,
  );
  return dp;
}

// Create a StateNotifier to manage the list of places
class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final sql.Database dp = await _getdatabase();

    final List<Map<String, dynamic>> placesData = await dp.query('user_places');

    List<Place> loadedPlaces = [];

    placesData.map((placeData) {
      loadedPlaces.add(
        Place(
          id: placeData['id'],
          title: placeData['title'],
          image: File(placeData['image'] as String),
          location: PlaceLocation(
            latitude: placeData['loc_lat'],
            longitude: placeData['loc_lng'],
            address: placeData['address'],
          ),
        ),
      );
    }).toList();

    loadedPlaces = loadedPlaces.reversed.toList();

    // Set the state to the loaded places
    state = loadedPlaces;
  }

  deletePlace(String id) async {
    // Get the database
    final dp = await _getdatabase();

    // Delete the place from the database using the id as the where clause
    await dp.delete('user_places', where: 'id = ?', whereArgs: [id]);

    // Remove the place from the state
    state = state.where((place) => place.id != id).toList();
  }

// PlaceLocation location,
  void addPlace(String title, File image, PlaceLocation location) async {
    // Get the application directory
    final Directory appDir = await syspaths.getApplicationDocumentsDirectory();

    // Get the filename from the image path
    final filename = path.basename(image.path);

    // Copy the image to the application directory
    final File copiedImage = await image.copy('${appDir.path}/$filename');

    // log(copiedImage.path);

    final newPlace = Place(
      title: title,
      image: copiedImage,
      location: location,
    );

    // Get the database
    final dp = await _getdatabase();
    // Insert the place into the database

    await dp.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    // Add the new place to the state
    state = [
      Place(
        // location,
        title: title,
        image: image,
        location: location,
        // staticMapImage: staticMapImage,
      ),
      ...state,
    ];
  }
}

// Create a StateNotifierProvider for the AddPlaceNotifier
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
