import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController _controller;
  static const LatLng _initialPosition = LatLng(-6.200000, 106.816666);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Screen'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: _initialPosition,
          zoom: 10.0,
        ),
        markers: _createMarkers(),  // Optional: Add markers
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      const Marker(
        markerId: MarkerId('initial_position'),
        position: _initialPosition,
        infoWindow: InfoWindow(
          title: 'Initial Position',
          snippet: 'This is where the map starts!',
        ),
      ),
    };
  }
}
