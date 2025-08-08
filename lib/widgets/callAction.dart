import 'package:flutter/material.dart';

class Callaction extends StatelessWidget {
  const Callaction({
    super.key,
    required this.icon,
    required this.label,
  });
  final IconData icon;
  final String label;


  @override
  Widget build(BuildContext context) {
    return    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white24,
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}