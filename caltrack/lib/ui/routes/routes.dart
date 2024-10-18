import 'package:caltrack/ui/screens/test/camera_screen.dart';
import 'package:caltrack/ui/screens/test/gemini_screen.dart';
import 'package:caltrack/ui/screens/test/home_screen.dart';
import 'package:caltrack/ui/screens/test/login_screen.dart';
import 'package:caltrack/ui/screens/test/navigator_screen.dart';
import 'package:caltrack/ui/screens/test/maps_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home      = '/home';
  static const String login     = '/login';
  static const String camera    = '/camera';
  static const String navigator = '/navigator';
  static const String maps      = '/maps';
  static const String gemini    = '/gemini';

  static Route<dynamic> generateRoute(RouteSettings settings) {
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
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
