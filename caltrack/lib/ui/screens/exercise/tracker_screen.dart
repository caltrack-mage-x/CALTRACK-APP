import 'dart:async';
import 'package:caltrack/ui/widgets/exercise/activity_selector.dart';
import 'package:caltrack/ui/widgets/exercise/map_view.dart';
import 'package:caltrack/ui/widgets/exercise/tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:caltrack/ui/widgets/exercise/location_service.dart';
import 'package:caltrack/ui/widgets/exercise/snackbar_helper.dart';
import 'package:intl/intl.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  LatLng? _currentPosition;
  String _selectedActivity = 'Cycling';
  int _kcal = 120;

  final LatLng _initialPosition = const LatLng(-7.966620, 112.632632);
  final SnackbarHelper _snackbarHelper = SnackbarHelper();
  final LocationService _locationService = LocationService();
  late TrackingController _trackingController;

  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _trackingController = TrackingController(
      locationService: _locationService,
      snackbarHelper: _snackbarHelper,
      onPositionUpdate: _updateMapView,
      currentPosition: _currentPosition ?? _initialPosition,
    );
  }

  Future<void> _getUserLocation() async {
    Position position = await _locationService.getCurrentPosition();
    _currentPosition = LatLng(position.latitude, position.longitude);
    _updateMapView(_currentPosition ?? _initialPosition, 15);
    _trackingController.setNewPosition(_currentPosition ?? _initialPosition);
  }

  void _updateMapView(LatLng newPosition, double newZoom) {
    setState(() {
      if (_currentPosition?.latitude != _initialPosition.latitude &&
          _currentPosition?.longitude != _initialPosition.longitude) {
        _trackingController.updatePathAndDistance(newPosition);
      }
      _currentPosition = newPosition;
    });

    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(newPosition, newZoom),
      );
    }
  }

  Set<Polyline> _createPolylines() {
    return {
      Polyline(
        polylineId: const PolylineId('path'),
        points: _trackingController.path,
        color: Colors.pink,
        width: 4,
      ),
    };
  }

  void _toggleTracking() {
    if (_trackingController.isTracking) {
      _trackingController.stopTracking(context);
      _updateMapView(_currentPosition ?? _initialPosition, 15);
      _trackingController.reset();
    } else {
      _trackingController.reset();
      setState(() {
        _trackingController.path.clear();
      });
      _trackingController.startTracking(context);
      _updateMapView(_currentPosition ?? _initialPosition, 18);
    }
  }


  void _toggleSimulatedMovement() {
    _trackingController.toggleSimulatedMovement(context);
  }

  void _showActivitySelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ActivitySelector(
          onSelectActivity: _selectActivity,
          selectedActivity: _selectedActivity,
        );
      },
    );
  }

  void _selectActivity(String activity) {
    setState(() {
      _selectedActivity = activity;
      _kcal = (activity == "Walking")
          ? 60
          : (activity == "Jogging")
          ? 80
          : 40;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map View
          MapView(
            initialCameraPosition: _initialPosition,
            currentPosition: _currentPosition,
            markers: _createMarkers(),
            polylines: _createPolylines(),
            onMapCreated: (controller) {
              _mapController = controller; // Capture the map controller
            },
          ),
          if (_trackingController.isTracking)
            Positioned(
              top: 30,
              left: 16,
              child: _buildDistanceMoved(),
            ),
          Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: _buildActivityInfo(),
          ),
          // Bottom buttons
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _toggleTracking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _trackingController.isTracking ? 'Stop Session' : 'Start Session',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                if (!_trackingController.isTracking)
                  const SizedBox(width: 8),
                if (!_trackingController.isTracking)
                  Container(
                    width: 60.0,
                    height: 60.0,
                    child: FloatingActionButton(
                      onPressed: _showActivitySelection,
                      backgroundColor: Colors.pink,
                      child: const Icon(Icons.change_circle, color: Colors.white),
                      shape: const CircleBorder(),
                    ),
                  ),
                const SizedBox(width: 8),
                // Toggle Simulated Movement Button
                if (!_trackingController.isTracking)
                  Container(
                    width: 60.0,
                    height: 60.0,
                    child: FloatingActionButton(
                      onPressed: _toggleSimulatedMovement,
                      backgroundColor: Colors.purple,
                      child: const Icon(Icons.directions_run, color: Colors.white),
                      shape: const CircleBorder(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceMoved() {
    double distanceInMeters = _trackingController.totalDistance;
    double caloriesBurned = _calculateCaloriesBurned(distanceInMeters);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.accessibility_new, color: Colors.pink), // Running icon
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${distanceInMeters.toStringAsFixed(2)} meters",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "${caloriesBurned.toStringAsFixed(2)} kcal burned",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateCaloriesBurned(double distanceInMeters) {
    double caloriesPerMeter;

    switch (_selectedActivity) {
      case 'Walking':
        caloriesPerMeter = 0.06;
        break;
      case 'Jogging':
        caloriesPerMeter = 0.08;
        break;
      case 'Cycling':
        caloriesPerMeter = 0.04;
        break;
      default:
        caloriesPerMeter = 0.06;
    }

    return distanceInMeters * caloriesPerMeter;
  }

  Widget _buildActivityInfo() {
    DateTime now = DateTime.now(); // Get the current date
    String formattedDate = DateFormat('EEE, MMM d | hh:mm a').format(now); // Format the date

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                _selectedActivity == 'Walking'
                    ? Icons.directions_walk
                    : _selectedActivity == 'Jogging'
                    ? Icons.directions_run
                    : Icons.directions_bike,
                color: Colors.pink,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedActivity,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '$_kcal kkal/km',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: const MarkerId('currentPosition'),
        position: _currentPosition ?? _initialPosition,
      ),
    };
  }
}
