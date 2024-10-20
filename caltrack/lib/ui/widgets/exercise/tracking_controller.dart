import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:caltrack/ui/widgets/exercise/location_service.dart';
import 'package:caltrack/ui/widgets/exercise/snackbar_helper.dart';

class TrackingController {
  bool isTracking = false;
  bool simulateMovement = true;
  LatLng? currentPosition;
  List<LatLng> path = [];
  double totalDistance = 0.0;
  Timer? timer;

  final LocationService locationService;
  final SnackbarHelper snackbarHelper;
  final Function onPositionUpdate;

  TrackingController({
    required this.locationService,
    required this.snackbarHelper,
    required this.onPositionUpdate,
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

  Future<void> getUserLocation() async {
    if (simulateMovement) {
      simulateUserMovement();
    } else {
      Position position = await locationService.getCurrentPosition();
      currentPosition = LatLng(position.latitude, position.longitude);
    }

    if (isTracking && currentPosition != null) {
      updatePathAndDistance(currentPosition!);
      onPositionUpdate(currentPosition!);
    }
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
    currentPosition = currentPosition == null
        ? const LatLng(-6.200000, 106.816666)
        : LatLng(currentPosition!.latitude + 0.0001, currentPosition!.longitude + 0.0001);
  }

  void toggleSimulatedMovement(BuildContext context) {
    simulateMovement = !simulateMovement;
    snackbarHelper.showSnackbar(context,
        simulateMovement ? 'Simulated movement started.' : 'Simulated movement stopped.');
  }

  void dispose() {
    timer?.cancel();
  }
}
