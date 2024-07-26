import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_places/models/place.dart';

import '../providers/user_places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? selectedImage;

  PlaceLocation? _pickedLocation;

  void addPlace() {
    final title = _titleController.text;
    if (title.isEmpty || selectedImage == null || _pickedLocation == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Missing Information'),
          content: const Text('Please fill in all the fields.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Okay',
                style: TextStyle(color: Color.fromARGB(255, 29, 20, 19)),
              ),
            ),
          ],
        ),
      );
    } else {
      //  _pickedLocation!,
      ref
          .read(userPlacesProvider.notifier)
          .addPlace(title, selectedImage!, _pickedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
                style:
                    const TextStyle(color: Color.fromARGB(255, 248, 234, 234)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              // Use the ImageInput widget
              onImageSelected: (image) {
                selectedImage = image;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            LocationInput(
              onSelectLocation: (loc) {
                _pickedLocation = loc;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: addPlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
