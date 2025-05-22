import 'package:flutter/material.dart';
import 'package:flutter_module/app/finik_provider_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finik QR Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const FinikProviderScreen(),
    );
  }
}
