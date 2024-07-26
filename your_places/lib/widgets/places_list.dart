import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';
import '../providers/user_places.dart';
import '../screens/place_details_screen.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (places.isEmpty) {
      return const Center(
        child: Text('Got no places yet, start adding some!',
            style: TextStyle(
                color: Color.fromARGB(255, 216, 208, 208), fontSize: 18)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemCount: places.length,
      itemBuilder: (ctx, i) => Dismissible(
        direction: DismissDirection.startToEnd,
        key: ValueKey(places[i].id),

        // icon

        background: Container(
          color: Colors.red[400],
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),

        // Delete the place when the user swipes the tile to the right
        onDismissed: (direction) {
          // Delete the place

          ref.read(userPlacesProvider.notifier).deletePlace(places[i].id);

          // Show a snackbar

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Place deleted'),
              duration: Duration(seconds: 1),
            ),
          );
        },

        // Confirm the deletion

        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: CircleAvatar(
            backgroundImage: FileImage(places[i].image),
            radius: 28,
          ),
          title: Text(places[i].title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 248, 234, 234), fontSize: 20)),
          subtitle: Text(places[i].location.address,
              style:
                  const TextStyle(color: Color.fromARGB(255, 216, 208, 208))),
          onTap: () {
            // Go to the details page

            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) => PlaceDetailScreen(
                        place: places[i],
                      )),
            );
          },
        ),
      ),
    );
  }
}
