import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/daily_forecast_card.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast = context.watch<WeatherProvider>().forecast;

    return Scaffold(
      appBar: AppBar(title: Text('5-Day Forecast')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          return DailyForecastCard(forecast: forecast[index]);
        },
      ),
    );
  }
}
