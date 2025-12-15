import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;

  WeatherModel? _currentWeather;
  List<ForecastModel> _forecast = [];
  WeatherState _state = WeatherState.initial;
  String _errorMessage = '';

  WeatherProvider(
    this._weatherService,
    this._locationService,
    this._storageService,
  );

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecast => _forecast;
  WeatherState get state => _state;
  String get errorMessage => _errorMessage;

  // Fetch weather by city
  Future<void> fetchWeatherByCity(String cityName) async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      _currentWeather = await _weatherService.getCurrentWeatherByCity(cityName);
      _forecast = await _weatherService.getForecast(cityName);
      await _storageService.saveWeatherData(_currentWeather!);

      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  // Fetch weather by current location
  // Fetch weather by current location
  // Fetch weather by current location
  Future<void> fetchWeatherByLocation() async {
    _state = WeatherState.loading;
    notifyListeners();

    try {
      // 1. Lấy tọa độ GPS
      final position = await _locationService.getCurrentLocation();

      // 2. Lấy thời tiết hiện tại từ tọa độ đó
      _currentWeather = await _weatherService.getCurrentWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      // --- SỬA ĐỔI TẠI ĐÂY ---
      // Thay vì dùng _locationService.getCityName (hay bị lỗi trên Windows),
      // chúng ta lấy luôn tên thành phố từ dữ liệu thời tiết vừa tải về.
      // API OpenWeatherMap đã tự động xác định tên thành phố cho bạn rồi.
      final cityName = _currentWeather!.cityName;
      // -----------------------

      // 3. Lấy dự báo thời tiết theo tên thành phố đó
      _forecast = await _weatherService.getForecast(cityName);

      await _storageService.saveWeatherData(_currentWeather!);

      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();

      // Try to load cached data
      await loadCachedWeather();
    }

    notifyListeners();
  }

  // Load cached weather
  Future<void> loadCachedWeather() async {
    final cachedWeather = await _storageService.getCachedWeather();
    if (cachedWeather != null) {
      _currentWeather = cachedWeather;
      _state = WeatherState.loaded;
      notifyListeners();
    }
  }

  // Refresh weather data
  Future<void> refreshWeather() async {
    if (_currentWeather != null) {
      await fetchWeatherByCity(_currentWeather!.cityName);
    } else {
      await fetchWeatherByLocation();
    }
  }
}
