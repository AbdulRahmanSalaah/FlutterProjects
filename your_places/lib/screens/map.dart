import 'dart:convert';
import 'dart:developer'; // Import for logging

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart'; // Import for location services
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.07,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _address = '';
  LatLng? _pickedLocation;
  final MapController _mapController = MapController();
  LatLng? _currentLocation;

  // Future to fetch the current location of the user  (if the user is selecting a location)
  Future<void>? _fetchLocationFuture;

  @override
  void initState() {
    super.initState();

    // if the user is selecting a location, get the current location
    if (widget.isSelecting) {
      _fetchLocationFuture = _getCurrentLocation();
    }
    // if the user is viewing a location, set the picked location to the location and fetch the address
    else {
      _pickedLocation =
          LatLng(widget.location.latitude, widget.location.longitude);
      _fetchAddress(_pickedLocation!.latitude, _pickedLocation!.longitude);
    }
  }

  // Function to get the current location of the user using the Geolocator plugin
  Future<void> _getCurrentLocation() async {
    try {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Set the current location and move the map to the current location
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _mapController.move(
          _currentLocation!,
          17.0,
        ); // Move map to current location with zoom level 17
      });
    } catch (e) {
      log('Error getting location: $e');
      // Handle location error (e.g., show an error message)
    }
  }

  // Function to handle the tap event on the map to select a location for the place
  // tagpostion is the position of the tap event and latlng is the latitude and longitude of the tapped location
  void _onMapTap(TapPosition tapPosition, LatLng latlng) {
    // If the user is not selecting a location, return
    if (!widget.isSelecting) {
      return;
    }

    // Set the picked location to the tapped location and fetch the address
    setState(() {
      _pickedLocation = latlng;
      _fetchAddress(latlng.latitude, latlng.longitude); // Fetch address
      log('Picked location: $_pickedLocation'); // Log the picked location
    });
  }

  // Function to fetch the address using the OpenStreetMap Nominatim API based on the latitude and longitude
  Future<void> _fetchAddress(double latitude, double longitude) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['address'] != null && data['display_name'] != null) {
      setState(() {
        _address = data['display_name'];
      });
    } else {
      setState(() {
        _address = 'No address found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                if (_pickedLocation != null) {
                  Navigator.of(context).pop(_pickedLocation);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a location first'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchLocationFuture,
        builder: (context, snapshot) {
          // If the location is still loading, show a loading indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the location
            return const Center(child: CircularProgressIndicator());
          }

          // If there is an error, show an error message
          else if (snapshot.hasError) {
            // Handle error
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // If the user is selecting a location, show the map with the current location
          else {
            return FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.isSelecting
                    ? _currentLocation ?? const LatLng(37.422, -122.07)
                    : _pickedLocation!,
                initialZoom: 17,
                onTap: _onMapTap,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                if (_pickedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _pickedLocation!,
                        child: const Icon(Icons.location_on,
                            color: Colors.red, size: 40),
                      ),
                    ],
                  ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () {
                        launchUrl(
                            Uri.parse('https://openstreetmap.org/copyright'));
                      },
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
      bottomSheet: Card(
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _address,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
