import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:caltrack/ui/widgets/exercise/location_service.dart';
import 'package:caltrack/ui/widgets/exercise/snackbar_helper.dart';
import 'package:path/path.dart';

class ActivitySelector extends StatelessWidget {
  final Function(String) onSelectActivity;
  final String selectedActivity;

  const ActivitySelector({
    Key? key,
    required this.onSelectActivity,
    required this.selectedActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0), // Increased left and right padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select activities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildActivityCard(context, "Walking", Icons.directions_walk,
                "A great way to enjoy nature while getting your steps in."),
            const SizedBox(height: 10),
            _buildActivityCard(context, "Jogging", Icons.directions_run,
                "Boost your cardiovascular health with a brisk jog."),
            const SizedBox(height: 10),
            _buildActivityCard(context, "Cycling", Icons.directions_bike,
                "Explore the outdoors and improve your leg strength with cycling."),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, String activity, IconData icon, String description) {
    return GestureDetector(
      onTap: () {
        onSelectActivity(activity);  // Call the callback to set the activity
        Navigator.pop(context);      // Dismiss the bottom sheet after selecting an activity
      },
      child: Container(
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
        child: ListTile(
          leading: Icon(icon, color: Colors.red, size: 30),
          title: Text(
            activity,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4), // Space between title and description
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}