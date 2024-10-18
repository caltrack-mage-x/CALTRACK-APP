import 'package:caltrack/ui/routes/routes.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigator Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.home);
              },
              child: Text('Go to Home Screen'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
              child: Text('Go to Login Screen'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.camera);
              },
              child: Text('Go to Camera Screen'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.maps);
              },
              child: Text('Go to Maps Screen'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.gemini);
              },
              child: Text('Go to Gemini Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
