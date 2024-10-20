import 'package:caltrack/ui/screens/challenge/challenge_screen.dart';
import 'package:caltrack/ui/screens/food/capture_screen.dart';
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
  static const String navigator = '/navigator-test';
  static const String maps      = '/maps-test';

  // Actual Page
  static const String challenge = '/challenge';
  static const String capture   = '/capture';

  static Route<dynamic> generateRoute(RouteSettings settings, List<CameraDescription> cameras) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case navigator:
        return MaterialPageRoute(builder: (_) => const NavigatorScreen());
      case maps:
        return MaterialPageRoute(builder: (_) => const MapsScreen());
      case challenge:
        return MaterialPageRoute(builder: (_) => const ChallengePage());
      case capture:
        final firstCamera =  cameras.first;
        final secondCamera = cameras.last;
        return MaterialPageRoute(builder: (_) => CaptureScreen(firstCamera: firstCamera, secondCamera: secondCamera));
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
