import 'package:ecommerce_app/core/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationMap extends StatefulWidget {
  static const String routeName = '/locationMap';

  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  TextEditingController searchController = TextEditingController();
  List<Marker> locationMarkers = [];
  //LatLng selectedLocation = LatLng(37.7749, -122.4194); // Default coordinates
  LatLng selectedLocation = new LatLng(6.8213425, 80.0415854);

  Future<void> searchLocation(String locationName) async {
    List<Location> locations = await locationFromAddress(locationName);

    if (locations.isNotEmpty) {
      final location = locations[0];
      final newLocation = LatLng(location.latitude, location.longitude);

      setState(() {
        // Clear previous markers
        locationMarkers.clear();

        // Add a new marker for the searched location
        locationMarkers.add(
          Marker(
            markerId: MarkerId('searchedLocation'),
            position: newLocation,
            infoWindow: InfoWindow(title: locationName),
          ),
        );

        // Update the map with the searched location
        selectedLocation = newLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Canteen Locations",
          style: TextStyle(fontSize: 25, color: blackColorShade1),  // Adjust text color
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 35,
            color: blackColorShade1, // Add icon color
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a canteen...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      searchLocation(searchController.text);
                    },
                    color: Colors.black, // Add icon color
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLocation,
                zoom: selectedLocation == null ? 0 : 10.0,
              ),
              markers: Set<Marker>.from(locationMarkers),
            ),
          ),
        ],
      ),
    );
  }
}
