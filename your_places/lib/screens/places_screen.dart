import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_places.dart';
import '../widgets/places_list.dart';
import 'add_place_screen.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {

  // this variable will hold the 'Future' object that will be resolved once the places are loaded
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    // Load the places when the screen is initialized from the local database using the 'loadPlaces' method
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlace = ref.watch(userPlacesProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),

          // Add a button to navigate to the 'Add Place' screen
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),

          // Use a 'FutureBuilder' widget to show the list of places once they are loaded from the local database
          child: FutureBuilder(
            // Pass the 'Future' object '_placesFuture' to the 'future' parameter, which will be resolved once the places are loaded
            future: _placesFuture,

            // Use the 'builder' parameter to build the UI based on the state of the 'Future'  
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              
              // Show a loading spinner while the places are being loaded
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Show an error message if the places fail to load

              else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              //  Show the list of places once they are loaded
              else {
                return PlacesList(
                  places: userPlace,
                );
              }
            },
          ),
        ));
  }
}
