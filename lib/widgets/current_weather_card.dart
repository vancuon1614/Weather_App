import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/weather_model.dart';
import '../utils/date_formatter.dart';
import '../utils/weather_icons.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    // Bỏ Container có màu nền, chỉ giữ lại nội dung
    return Column(
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 3,
                color: Colors.black26,
              ),
            ],
          ),
        ),
        Text(
          DateFormatter.formatDate(weather.dateTime),
          style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9)),
        ),
        const SizedBox(height: 10),

        // Icon thời tiết to
        CachedNetworkImage(
          imageUrl: WeatherIcons.getUrl(weather.icon),
          height: 120,
          width: 120,
          fit: BoxFit.contain,
          placeholder: (context, url) =>
              const CircularProgressIndicator(color: Colors.white),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.white),
        ),

        // Nhiệt độ
        Text(
          '${weather.temperature.round()}°',
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            height: 1.0, // Giảm khoảng cách dòng
          ),
        ),

        // Mô tả
        Text(
          weather.description.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
