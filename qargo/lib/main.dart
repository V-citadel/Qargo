import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';
import 'pages/create_shipment_page.dart';
import 'pages/shipment_confirmation_page.dart';
import 'pages/truck_request_page.dart';
import 'pages/shipper_dashboard_page.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qargo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegistrationPage(),
        '/create-shipment': (context) => CreateShipmentPage(),
        '/truck-request': (context) => TruckRequestPage(),
        '/shipment-confirmation': (context) => const ShipmentConfirmationPage(),
        '/dashboard': (context) => const ShipperDashboardPage(),
        
      },
    );
  }
}
