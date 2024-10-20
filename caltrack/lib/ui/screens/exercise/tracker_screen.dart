import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:caltrack/ui/widgets/exercise/location_service.dart';
import 'package:caltrack/ui/widgets/exercise/snackbar_helper.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  late GoogleMapController _controller;
  LatLng? _currentPosition;
  bool _locationPermissionGranted = false;
  bool _isLoading = true;
  bool _isTracking = false;
  bool _simulateMovement = false;
  Timer? _timer;
  List<LatLng> _path = [];
  double _totalDistance = 0.0;
  String _mapStyle = '';

  final LatLng _initialPosition = const LatLng(-6.200000, 106.816666);
  final SnackbarHelper _snackbarHelper = SnackbarHelper();
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _initializeTracker();
  }

  Future<void> _initializeTracker() async {
    _mapStyle = await _loadMapStyle();
    _locationPermissionGranted = await _locationService.checkLocationPermission();
    if (_locationPermissionGranted) {
      await _getUserLocation();
      _startTrackingLocation();
    } else {
      _setLoading(false);
    }
  }

  Future<String> _loadMapStyle() async {
    return await rootBundle.loadString('assets/maps.json');
  }

  void _toggleTracking() async {
    _isTracking ? _stopTracking() : await _startTracking();
  }

  Future<void> _startTracking() async {
    if (_currentPosition == null) await _getUserLocation();
    _isTracking = true;
    _snackbarHelper.showSnackbar(context, 'Tracking started.');
    _startTrackingLocation();
    _animateCameraToPosition(_currentPosition!, 18.0);
  }

  void _stopTracking() {
    _isTracking = false;
    _simulateMovement = false;
    _timer?.cancel();
    _snackbarHelper.showSnackbar(context, 'Tracking stopped. Total distance: ${_totalDistance.toStringAsFixed(2)} meters.');
    _animateCameraToPosition(_currentPosition!, 15.0);
  }

  void _startTrackingLocation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _getUserLocation();
    });
  }

  Future<void> _getUserLocation() async {
    try {
      if (_simulateMovement) {
        _simulateUserMovement();
      } else {
        Position position = await _locationService.getCurrentPosition();
        _currentPosition = LatLng(position.latitude, position.longitude);
      }

      if (_isTracking && _currentPosition != null) {
        _updatePathAndDistance(_currentPosition!);
        _animateCameraToPosition(_currentPosition!, 18.0);
      }

      _setLoading(false);
    } on TimeoutException {
      _snackbarHelper.showSnackbar(context, 'Request for location timed out. Please try again.');
    } catch (e) {
      _snackbarHelper.handleError(context, e);
    }
  }

  void _updatePathAndDistance(LatLng newPosition) {
    _path.add(newPosition);
    if (_path.length > 1) {
      double distance = Geolocator.distanceBetween(
        _path[_path.length - 2].latitude,
        _path[_path.length - 2].longitude,
        newPosition.latitude,
        newPosition.longitude,
      );
      _totalDistance += distance;
    }
  }

  void _animateCameraToPosition(LatLng position, double zoom) {
    _controller.animateCamera(CameraUpdate.newLatLngZoom(position, zoom));
  }

  void _simulateUserMovement() {
    _currentPosition = _currentPosition == null ? _initialPosition : LatLng(
        _currentPosition!.latitude + 0.0001, _currentPosition!.longitude + 0.0001);
  }

  void _toggleSimulatedMovement() {
    _simulateMovement = !_simulateMovement;
    _snackbarHelper.showSnackbar(context, _simulateMovement ? 'Simulated movement started.' : 'Simulated movement stopped.');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _controller.setMapStyle(_mapStyle);
              if (_currentPosition != null) {
                _animateCameraToPosition(_currentPosition!, 15.0);
              }
            },
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15.0,
            ),
            markers: _createMarkers(),
            polylines: _createPolylines(),
            myLocationEnabled: _locationPermissionGranted,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: _isTracking ? null : _toggleTracking,
                  child: const Icon(Icons.play_arrow, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: _isTracking ? _stopTracking : null,
                  child: const Icon(Icons.stop, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: _isTracking ? _toggleSimulatedMovement : null,
                  child: const Icon(Icons.directions_run, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Total Distance: ${_totalDistance.toStringAsFixed(2)} m',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
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

  Set<Polyline> _createPolylines() {
    return {
      if (_path.isNotEmpty)
        Polyline(
          polylineId: const PolylineId('tracking_path'),
          points: _path,
          color: Colors.blue,
          width: 5,
        ),
    };
  }
}
