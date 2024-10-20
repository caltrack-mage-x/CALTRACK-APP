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
  bool _isLoading = true;

  String _selectedActivity = 'Cycling';
  int _kcal = 120;

  final LatLng _initialPosition = const LatLng(-6.200000, 106.816666);
  final SnackbarHelper _snackbarHelper = SnackbarHelper();
  final LocationService _locationService = LocationService();
  late TrackingController _trackingController;

  @override
  void initState() {
    super.initState();
    _trackingController = TrackingController(
      locationService: _locationService,
      snackbarHelper: _snackbarHelper,
      onPositionUpdate: _updateMapView,
    );
    _initializeTracker();
  }

  Future<void> _initializeTracker() async {
    await _getUserLocation();
    _trackingController.startTracking(context);
    _setLoading(false);
  }

  Future<void> _getUserLocation() async {
    Position position = await _locationService.getCurrentPosition();
    _currentPosition = LatLng(position.latitude, position.longitude);
  }

  void _updateMapView(LatLng newPosition) {
    setState(() {
      _currentPosition = newPosition;
    });
  }

  void _toggleTracking() {
    if (_trackingController.isTracking) {
      _trackingController.stopTracking(context);
    } else {
      _trackingController.startTracking(context);
    }
    setState(() {}); // Ensure UI is updated when tracking status changes
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          // Map View
          MapView(
            initialCameraPosition: _initialPosition,
            currentPosition: _currentPosition,
            markers: _createMarkers(),
            polylines: _createPolylines(),
            onMapCreated: (controller) {
              // Additional actions on map creation
            },
          ),
          // Display meters moved and calories burned in the top-left corner
          if (_trackingController.isTracking)
            Positioned(
              top: 30,
              left: 16,
              child: _buildDistanceMoved(),
            ),
          // Activity Info Display (history card)
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
                // Expanded Start/Stop Session button
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
                // Show plus button only if not tracking
                if (!_trackingController.isTracking)
                  const SizedBox(width: 8), // Add space between buttons
                if (!_trackingController.isTracking)
                  Container(
                    width: 60.0,
                    height: 60.0,
                    child: FloatingActionButton(
                      onPressed: _showActivitySelection,
                      backgroundColor: Colors.pink,
                      child: const Icon(Icons.change_circle, color: Colors.white),
                      shape: CircleBorder(),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Distance moved and calories burned display
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                "${caloriesBurned.toStringAsFixed(2)} kcal burned",
                style: const TextStyle(fontSize: 14, color: Colors.black54), // Lighter text for calories
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Calculate calories burned based on distance and activity type
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

  // History card with white background and pink text/icon
  Widget _buildActivityInfo() {
    DateTime now = DateTime.now(); // Get the current date
    String formattedDate = DateFormat('EEE, MMM d | hh:mm a').format(now); // Format the date

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Background is now white
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
                color: Colors.pink, // Icon is now pink
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedActivity,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink), // Text is now pink
                  ),
                  Text(
                    formattedDate, // Display the formatted date
                    style: const TextStyle(fontSize: 14, color: Colors.black), // Text is black for visibility
                  ),
                ],
              ),
            ],
          ),
          Text(
            '$_kcal kkal/km',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink), // Kcal is now pink
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentPosition ?? _initialPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ),
    };
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

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _trackingController.dispose();
    super.dispose();
  }
}
