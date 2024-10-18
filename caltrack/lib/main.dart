import 'package:caltrack/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oypqnvowydydwaddaith.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im95cHFudm93eWR5ZHdhZGRhaXRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY4MjU0OTAsImV4cCI6MjA0MjQwMTQ5MH0.bWK6aXjgWrm_gdnPazCcEfxYTUp550sotiWJDZATGcU',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'CalTrack',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppRoutes.navigator,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
