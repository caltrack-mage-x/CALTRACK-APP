import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  late GoogleMapController _controller;
  static const LatLng _initialPosition = LatLng(-6.200000, 106.816666);
  LatLng? _currentPosition;
  bool _locationPermissionGranted = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is denied.')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _locationPermissionGranted = true;
    });

    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10), // Timeout after 10 seconds
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false; // Stop loading when location is fetched
      });

      _moveCameraToPosition(_currentPosition!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get location. Please try again.')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _moveCameraToPosition(LatLng position) {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 14.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracker Screen'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          if (_currentPosition != null) {
            _moveCameraToPosition(_currentPosition!);
          }
        },
        initialCameraPosition: const CameraPosition(
          target: _initialPosition,
          zoom: 10.0,
        ),
        markers: _createMarkers(),
        myLocationEnabled: _locationPermissionGranted,
        myLocationButtonEnabled: true,
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      if (_currentPosition != null)
        Marker(
          markerId: const MarkerId('current_position'),
          position: _currentPosition!,
          infoWindow: const InfoWindow(
            title: 'Your Location',
            snippet: 'This is your current position!',
          ),
        ),
    };
  }
}
