import 'package:flutter/material.dart';

class WeatherDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const WeatherDetailItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(height: 5),
        Text(title, style: TextStyle(color: Colors.grey)),
        SizedBox(height: 5),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
