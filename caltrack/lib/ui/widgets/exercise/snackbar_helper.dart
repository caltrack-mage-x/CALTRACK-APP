import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SnackbarHelper {
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void handleError(BuildContext context, Object error) {
    String errorMessage = '';
    if (error is PermissionDeniedException) {
      errorMessage = 'Location permission was denied.';
    } else if (error is LocationServiceDisabledException) {
      errorMessage = 'Location services are disabled.';
    }

    if (errorMessage.isNotEmpty) {
      showSnackbar(context, errorMessage);
    }
  }
}