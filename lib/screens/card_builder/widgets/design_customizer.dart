import 'package:flutter/material.dart';

class DesignCustomizer extends StatelessWidget {
  const DesignCustomizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Design Customizer',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
