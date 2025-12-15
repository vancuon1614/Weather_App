import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../config/api_config.dart';

class WeatherService {
  final String apiKey;

  WeatherService({required this.apiKey});

  // Get current weather by city name
  Future<WeatherModel> getCurrentWeatherByCity(String cityName) async {
    try {
      final url = ApiConfig.buildUrl(
        ApiConfig.currentWeather,
        {'q': cityName},
        apiKey, // <-- Truyền apiKey vào đây
      );

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception(
          'Failed to load weather data (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get current weather by coordinates
  Future<WeatherModel> getCurrentWeatherByCoordinates(
    double lat,
    double lon,
  ) async {
    try {
      final url = ApiConfig.buildUrl(
        ApiConfig.currentWeather,
        {'lat': lat.toString(), 'lon': lon.toString()},
        apiKey, // <-- Truyền apiKey vào đây
      );

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Failed to load weather data (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get 5-day forecast
  Future<List<ForecastModel>> getForecast(String cityName) async {
    try {
      final url = ApiConfig.buildUrl(
        ApiConfig.forecast,
        {'q': cityName},
        apiKey, // <-- Truyền apiKey vào đây
      );

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> forecastList = data['list'];
        return forecastList
            .map((item) => ForecastModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get weather icon URL
  String getIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }
}
