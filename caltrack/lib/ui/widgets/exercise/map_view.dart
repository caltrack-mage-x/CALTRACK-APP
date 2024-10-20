import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:caltrack/ui/widgets/exercise/location_service.dart';
import 'package:caltrack/ui/widgets/exercise/snackbar_helper.dart';

class MapView extends StatefulWidget {
  final LatLng initialCameraPosition;
  final LatLng? currentPosition;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final Function(GoogleMapController) onMapCreated;

  const MapView({
    Key? key,
    required this.initialCameraPosition,  // Change this
    required this.currentPosition,
    required this.markers,
    required this.polylines,
    required this.onMapCreated,
  }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        widget.onMapCreated(_controller);
        if (widget.currentPosition != null) {
          _animateCameraToPosition(widget.currentPosition!, 15.0);
        }
      },
      initialCameraPosition: CameraPosition(
        target: widget.initialCameraPosition,  // Change this
        zoom: 15.0,
      ),
      markers: widget.markers,
      polylines: widget.polylines,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    );
  }

  void _animateCameraToPosition(LatLng position, double zoom) {
    _controller.animateCamera(CameraUpdate.newLatLngZoom(position, zoom));
  }
}
