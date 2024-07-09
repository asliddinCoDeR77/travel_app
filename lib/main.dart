import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permissions/services/location_services.dart';
import 'package:permissions/splashscreen/splash_screeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // PermissionStatus cameraPermission = await Permission.camera.status;
  // PermissionStatus locationPermission = await Permission.location.status;
  // print(cameraPermission);
  // if (cameraPermission == PermissionStatus.denied) {
  //   cameraPermission = await Permission.camera.request();
  //   print(cameraPermission);
  // }
  // if (locationPermission == PermissionStatus.denied) {
  //   locationPermission = await Permission.location.request();
  //   print(locationPermission);
  // }

  // final statuses = [
  //   Permission.location,
  //   Permission.camera,
  // ].request();

  // print(statuses);

  await LocationServices.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      dark: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        theme: theme,
        darkTheme: darkTheme,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
