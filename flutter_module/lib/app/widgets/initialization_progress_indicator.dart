import 'package:flutter/material.dart';

class InitializationProgressIndicator extends StatelessWidget {
  const InitializationProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: Color(0xFF252424),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
