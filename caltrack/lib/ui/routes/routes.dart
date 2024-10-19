import 'package:caltrack/ui/screens/challenge/challenge_screen.dart';
import 'package:caltrack/ui/screens/food/capture_screen.dart';
import 'package:caltrack/ui/screens/test/camera_screen.dart';
import 'package:caltrack/ui/screens/test/gemini_screen.dart';
import 'package:caltrack/ui/screens/test/home_screen.dart';
import 'package:caltrack/ui/screens/test/login_screen.dart';
import 'package:caltrack/ui/screens/test/navigator_screen.dart';
import 'package:caltrack/ui/screens/test/maps_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // Test Page
  static const String home      = '/home-test';
  static const String login     = '/login-test';
  static const String camera    = '/camera-test';
  static const String navigator = '/navigator-test';
  static const String maps      = '/maps-test';
  static const String gemini    = '/gemini-test';

  // Actual Page
  static const String challenge = '/challenge';
  static const String capture   = '/capture';

  static Route<dynamic> generateRoute(RouteSettings settings, List<CameraDescription> cameras) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case camera:
        return MaterialPageRoute(builder: (_) => CameraScreen());
      case navigator:
        return MaterialPageRoute(builder: (_) => NavigatorScreen());
      case maps:
        return MaterialPageRoute(builder: (_) => MapsScreen());
      case gemini:
        return MaterialPageRoute(builder: (_) => GeminiScreen());
      case challenge:
        return MaterialPageRoute(builder: (_) => ChallengePage());
      case capture:
        final firstCamera =  cameras.first;
        return MaterialPageRoute(builder: (_) => CaptureScreen(camera: firstCamera));
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
