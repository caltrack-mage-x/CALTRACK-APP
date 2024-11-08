import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:caltrack/ui/widgets/exercise/location_service.dart';
import 'package:caltrack/ui/widgets/exercise/snackbar_helper.dart';

class TrackingController {
  bool isTracking = false;
  bool simulateMovement = false;
  LatLng currentPosition;
  List<LatLng> path = [];
  double totalDistance = 0.0;
  Timer? timer;

  final LocationService locationService;
  final SnackbarHelper snackbarHelper;
  final Function(LatLng, double) onPositionUpdate;

  final double movementSpeed = 0.00002;
  final double directionChangeRate = 0.000005;

  TrackingController({
    required this.locationService,
    required this.snackbarHelper,
    required this.onPositionUpdate,
    required this.currentPosition,
  });

  Future<void> startTracking(BuildContext context) async {
    isTracking = true;
    snackbarHelper.showSnackbar(context, 'Tracking started.');
    startTrackingLocation();
  }

  void stopTracking(BuildContext context) {
    isTracking = false;
    simulateMovement = false;
    timer?.cancel();
    snackbarHelper.showSnackbar(
        context, 'Tracking stopped. Total distance: ${totalDistance.toStringAsFixed(2)} meters.');
  }

  void startTrackingLocation() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      getUserLocation();
    });
  }

  void getUserLocation() async {
    if (simulateMovement) {
      simulateUserMovement();
    } else {
      Position position = await locationService.getCurrentPosition();
      currentPosition = LatLng(position.latitude, position.longitude);
    }

    if (isTracking) {
      updatePathAndDistance(currentPosition);
      onPositionUpdate(currentPosition, 18);
    }
  }

  void setNewPosition(LatLng newPosition){
    currentPosition = newPosition;
  }


  void updatePathAndDistance(LatLng newPosition) {
    path.add(newPosition);
    if (path.length > 1) {
      double distance = Geolocator.distanceBetween(
        path[path.length - 2].latitude,
        path[path.length - 2].longitude,
        newPosition.latitude,
        newPosition.longitude,
      );
      totalDistance += distance;
    }
  }

  void simulateUserMovement() {
    double latChange = movementSpeed + (directionChangeRate * (path.length % 2 == 0 ? -1 : 1));
    double lngChange = movementSpeed + (directionChangeRate * (path.length % 3 == 0 ? -1 : 1));

    currentPosition = LatLng(
      currentPosition.latitude + latChange,
      currentPosition.longitude + lngChange,
    );

    updatePathAndDistance(currentPosition);
    onPositionUpdate(currentPosition, 18);
  }

  void toggleSimulatedMovement(BuildContext context) {
    simulateMovement = !simulateMovement;
    snackbarHelper.showSnackbar(context,
        simulateMovement ? 'Simulated movement started.' : 'Simulated movement stopped.');
  }

  void reset(){
    this.path = [];
    this.totalDistance = 0.0;
    getUserLocation();
  }

  void dispose() {
    timer?.cancel();
  }
}
